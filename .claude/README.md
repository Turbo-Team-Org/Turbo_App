# `.claude/` — Turbo_App (subproyecto)

> Esta carpeta solo contiene configuración local del subproyecto.
> **El sistema agéntico vive en el workspace** (`/Turbo_Workspace/.claude/`).

## Dónde está cada cosa

| Recurso | Ubicación canónica |
|---|---|
| Agentes (`tdd-planner`, `tdd-implementer`, `tdd-verifier`, `tdd-orchestrator`, `knowledge-sync`) | `/.claude/agents/` |
| Commands (`/plan`, `/tdd`, `/test`, `/implement`, `/doc`, `/feature`, `/review`) | `/.claude/commands/` |
| Workflows (feature, tdd, bugfix, mvp) | `/.claude/workflows/` |
| Templates Dart (cubit, state, screen, use case…) | `/.claude/templates/` |
| Hooks (pre-commit, coverage, etc.) | `/.claude/hooks/` |
| Skills (feature-tdd-cycle, release-readiness, jira-mcp-bridge) | `/.claude/skills/` |
| Sprints | `/.claude/sprints/` |
| Plans/handoffs por feature | `/.claude/features/<id>/` |

## Contexto específico del subproyecto

- **CLAUDE.md** del subproyecto: `Turbo_App/CLAUDE.md` — solo describe lo único de la app móvil (l10n, `turbo_ui`, `auto_route 9.2.2`, `fvm flutter`, etc.).
- **CLAUDE.md** del workspace: `/CLAUDE.md` — visión cross-repo, política TDD global, MVP, mapa de proyectos.

## Cómo arrancar una sesión agéntica para esta app

1. Lee `/CLAUDE.md` (paraguas).
2. Lee `Turbo_App/CLAUDE.md` (específico).
3. Lee el sprint activo en `/.claude/sprints/`.
4. Si hay handoff de feature: `/.claude/features/<feature-id>/HANDOFF.md`.
5. Invoca el comando correspondiente (`/plan`, `/tdd`, `/feature <id>`, etc.).

**GitHub:** las PR se abren contra **`develop`** (`gh pr create --base develop`), no contra `main` salvo release explícita — ver `/CLAUDE.md` y `/.claude/agents/tdd-verifier.md` §2.6.

**Antes de una nueva feature:** actualizar **`develop`** (`git fetch && git checkout develop && git pull origin develop`) o, desde la raíz del monorepo `Turbo_Workspace/`, `bash .claude/hooks/branch-sync.sh` para alinear Core, App y Admin.

## settings.json

Mantiene configuración local de la app (paths, model preferences específicas si las hay). El resto se hereda del workspace.
