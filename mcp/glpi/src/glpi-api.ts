/**
 * Cliente mínimo API REST GLPI 9.x/10.x (initSession + GET Ticket).
 * Requiere App-Token y User-Token; no versionar valores reales.
 */

function baseUrl(): string | null {
  const u = process.env.GLPI_BASE_URL?.trim();
  return u && u.length > 0 ? u.replace(/\/+$/, "") : null;
}

function apirest(base: string, path: string): string {
  const p = path.startsWith("/") ? path : `/${path}`;
  if (base.includes("/apirest.php")) {
    return `${base}${p}`;
  }
  return `${base}/apirest.php${p}`;
}

let sessionTokenCache: string | null = null;

async function initSession(): Promise<{ ok: true; token: string } | { ok: false; mensaje: string }> {
  const base = baseUrl();
  const app = process.env.GLPI_APP_TOKEN?.trim();
  const user = process.env.GLPI_USER_TOKEN?.trim();
  if (!base || !app || !user) {
    return {
      ok: false,
      mensaje:
        "Faltan GLPI_BASE_URL, GLPI_APP_TOKEN o GLPI_USER_TOKEN en el entorno (.env).",
    };
  }
  if (sessionTokenCache) {
    return { ok: true, token: sessionTokenCache };
  }
  const url = apirest(base, "/initSession");
  const res = await fetch(url, {
    method: "GET",
    headers: {
      Authorization: `user_token ${user}`,
      "App-Token": app,
      "Content-Type": "application/json",
    },
  });
  const text = await res.text();
  if (!res.ok) {
    return {
      ok: false,
      mensaje: `initSession HTTP ${res.status}: ${text.slice(0, 500)}`,
    };
  }
  try {
    const data = JSON.parse(text) as { session_token?: string };
    if (!data.session_token) {
      return { ok: false, mensaje: "Respuesta initSession sin session_token." };
    }
    sessionTokenCache = data.session_token;
    return { ok: true, token: data.session_token };
  } catch {
    return { ok: false, mensaje: `JSON inválido en initSession: ${text.slice(0, 200)}` };
  }
}

export async function obtenerTicketPorId(
  id: number,
): Promise<{ ok: true; ticket: unknown } | { ok: false; mensaje: string }> {
  const base = baseUrl();
  if (!base) {
    return { ok: false, mensaje: "GLPI_BASE_URL no configurada." };
  }
  const ses = await initSession();
  if (!ses.ok) {
    return { ok: false, mensaje: ses.mensaje };
  }
  const url = `${apirest(base, `/Ticket/${id}`)}?session_token=${encodeURIComponent(ses.token)}`;
  const res = await fetch(url, {
    method: "GET",
    headers: {
      "App-Token": process.env.GLPI_APP_TOKEN ?? "",
      "Content-Type": "application/json",
    },
  });
  const text = await res.text();
  if (!res.ok) {
    return {
      ok: false,
      mensaje: `GET Ticket HTTP ${res.status}: ${text.slice(0, 500)}`,
    };
  }
  try {
    return { ok: true, ticket: JSON.parse(text) };
  } catch {
    return { ok: false, mensaje: `JSON inválido: ${text.slice(0, 200)}` };
  }
}
