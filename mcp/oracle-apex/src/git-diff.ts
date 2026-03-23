/**
 * Ejecuta `git diff --stat` en un repositorio local (sin credenciales remotas).
 */
import { spawnSync } from "node:child_process";

export function ejecutarGitDiffStat(repoPath: string, ref?: string): {
  ok: boolean;
  salida: string;
  error?: string;
} {
  const args = ["diff", "--stat"];
  if (ref && ref.length > 0) {
    args.push(ref);
  }
  const r = spawnSync("git", args, {
    cwd: repoPath,
    encoding: "utf-8",
    maxBuffer: 4 * 1024 * 1024,
  });
  if (r.error) {
    return {
      ok: false,
      salida: "",
      error: r.error.message,
    };
  }
  if (r.status !== 0) {
    const err =
      r.stderr?.trim() ||
      `git terminó con código ${r.status ?? "desconocido"}`;
    return { ok: false, salida: r.stdout ?? "", error: err };
  }
  return { ok: true, salida: r.stdout?.trim() ?? "(sin cambios)" };
}

export function resolverRutaRepo(): string {
  const p = process.env.GIT_REPO_PATH?.trim();
  if (p && p.length > 0) {
    return p;
  }
  return process.cwd();
}
