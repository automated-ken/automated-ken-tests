# automated-ken-tests

YARF snap testing repository, managed by [snap-dashboard](https://github.com/kenvandine/automated-ken).

Test results are published as pull requests in this repository. snap-dashboard polls the PRs and displays pass/fail status with screenshots inline.

## Repository setup

### 1. GitHub Actions secret

Add a repository secret named `SNAP_DASHBOARD_GITHUB_TOKEN` with a Personal Access Token that has **repo** scope. This allows the workflow to push result branches and open PRs.

Optional: add `SNAPCRAFT_STORE_CREDENTIALS` if any snap requires store-authenticated installation.

### 2. Configure snap-dashboard

In snap-dashboard **Settings**, set **Testing Repository** to `kenvandine/automated-ken-tests`.

## Test suite structure

Each snap has its own suite directory:

```
suites/<snap_name>/suite/
├── __init__.robot          # Suite setup/teardown (variables, display init, etc.)
└── test_<snapname>.robot   # Test cases
```

The GitHub Actions workflow looks for suites at `suites/<snap_name>/suite/` and expects `__init__.robot` to be present.

## GitHub Actions workflow

The workflow at `.github/workflows/snap-test.yml` is triggered by snap-dashboard via `workflow_dispatch`. It:

1. Installs `xvfb`, `yarf` (beta), `mir-test-tools`, and the snap under test
2. Starts a virtual X11 display (`Xvfb :99`) for the Mir compositor
3. Runs YARF with `--platform Mir` against the snap's suite
4. Uploads test artifacts (results + screenshots)
5. Commits results to a branch and opens a PR back to `main`

### Workflow inputs

| Input | Description |
|-------|-------------|
| `snap_name` | Snap to test |
| `from_channel` | Channel to install from (`candidate` or `edge`) |
| `architecture` | `amd64` or `arm64` |
| `version` | Expected version string (informational) |
| `revision` | Expected revision number (informational) |
| `dashboard_run_id` | snap-dashboard TestRun ID (echoed into PR metadata) |

## Running tests locally

```bash
# Install YARF
sudo snap install --beta yarf
sudo snap install mir-test-tools
sudo snap connect yarf:process-control

# Install the snap under test
sudo snap install mysnap --channel candidate

# Start virtual display
sudo apt-get install -y xvfb
Xvfb :99 -screen 0 1920x1080x24 &

# Run tests
DISPLAY=:99 yarf --platform Mir --outdir results/mysnap suites/mysnap/suite
```

## Test result PRs

Each test run creates a branch `test-results/<snap>/<gh_run_id>` and opens a PR titled:

- `✅ mysnap 1.2.3 (candidate) — passed`
- `❌ mysnap 1.2.3 (candidate) — failed`

The PR body contains a results table, screenshots (if any PNGs were written to `results/<snap>/`), and an HTML comment with machine-readable metadata used by snap-dashboard.

## Existing suites (74 total)

### Desktop Applications (10)

| Snap | Suite location |
|------|---------------|
| `ask-ubuntu` | `suites/ask-ubuntu/suite/` |
| `element-desktop` | `suites/element-desktop/suite/` |
| `fractal` | `suites/fractal/suite/` |
| `lemonade` | `suites/lemonade/suite/` |
| `lemonade-desktop` | `suites/lemonade-desktop/suite/` |
| `deepseek-desktop` | `suites/deepseek-desktop/suite/` |
| `perplexity-desktop` | `suites/perplexity-desktop/suite/` |
| `copilot-desktop` | `suites/copilot-desktop/suite/` |
| `duck-ai` | `suites/duck-ai/suite/` |

### Utilities & Tools (15)

| Snap | Suite location |
|------|---------------|
| `authenticator` | `suites/authenticator/suite/` |
| `cheese` | `suites/cheese/suite/` |
| `evince` | `suites/evince/suite/` |
| `glade` | `suites/glade/suite/` |
| `gnome-font-viewer` | `suites/gnome-font-viewer/suite/` |
| `gnome-info-collect` | `suites/gnome-info-collect/suite/` |
| `neofetch-desktop` | `suites/neofetch-desktop/suite/` |
| `piper-tts` | `suites/piper-tts/suite/` |
| `whisper-stt` | `suites/whisper-stt/suite/` |
| `xournalpp` | `suites/xournalpp/suite/` |
| `dippi` | `suites/dippi/suite/` |
| `aqueducts` | `suites/aqueducts/suite/` |
| `ASHPD-Demo` | `suites/ASHPD-Demo/suite/` |
| `pixieditor` | `suites/pixieditor/suite/` |

### Games (23)

| Snap | Suite location |
|------|---------------|
| `fifteenpuzzle` | `suites/fifteenpuzzle/suite/` |
| `gnome-chess` | `suites/gnome-chess/suite/` |
| `gnome-klotski` | `suites/gnome-klotski/suite/` |
| `gnome-mahjongg` | `suites/gnome-mahjongg/suite/` |
| `gnome-mines` | `suites/gnome-mines/suite/` |
| `gnome-robots` | `suites/gnome-robots/suite/` |
| `gnome-tetravex` | `suites/gnome-tetravex/suite/` |
| `gnome-taquin` | `suites/gnome-taquin/suite/` |
| `gnome-nibbles` | `suites/gnome-nibbles/suite/` |
| `gnome-recipes` | `suites/gnome-recipes/suite/` |
| `Iagno` | `suites/Iagno/suite/` |
| `lightsoff` | `suites/lightsoff/suite/` |
| `tali` | `suites/tali/suite/` |
| `terminal-2048` | `suites/terminal-2048/suite/` |
| `terminal-solitaire` | `suites/terminal-solitaire/suite/` |
| `terminal-tetris` | `suites/terminal-tetris/suite/` |
| `terminal-fun` | `suites/terminal-fun/suite/` |
| `tank-warriors` | `suites/tank-warriors/suite/` |
| `dragons-apprentice` | `suites/dragons-apprentice/suite/` |
| `infinity-arcade` | `suites/infinity-arcade/suite/` |
| `missilemath` | `suites/missilemath/suite/` |
| `The-Passage` | `suites/The-Passage/suite/` |
| `Thrive` | `suites/Thrive/suite/` |

### Development & Tools (14)

| Snap | Suite location |
|------|---------------|
| `godot4` | `suites/godot4/suite/` |
| `gimp` | `suites/gimp/suite/` |
| `code` | `suites/code/suite/` |
| `fresh-editor` | `suites/fresh-editor/suite/` |
| `glade` | `suites/glade/suite/` |
| `github-user-stats` | `suites/github-user-stats/suite/` |
| `gtk-3-examples` | `suites/gtk-3-examples/suite/` |
| `gtk-3-test` | `suites/gtk-3-test/suite/` |
| `gtk-theme-pop` | `suites/gtk-theme-pop/suite/` |
| `gtk-theme-traditionalhumanized` | `suites/gtk-theme-traditionalhumanized/suite/` |
| `openmoonray` | `suites/openmoonray/suite/` |
| `open-model-zoo` | `suites/open-model-zoo/suite/` |
| `proton-lumo-ai` | `suites/proton-lumo-ai/suite/` |
| `screen-test` | `suites/screen-test/suite/` |

### AI & Communication (6)

| Snap | Suite location |
|------|---------------|
| `deepseek-desktop` | `suites/deepseek-desktop/suite/` |
| `perplexity-desktop` | `suites/perplexity-desktop/suite/` |
| `copilot-desktop` | `suites/copilot-desktop/suite/` |
| `duck-ai` | `suites/duck-ai/suite/` |
| `proton-lumo-ai` | `suites/proton-lumo-ai/suite/` |
| `piper-tts` | `suites/piper-tts/suite/` |
| `whisper-stt` | `suites/whisper-stt/suite/` |

### Other Apps (6)

| Snap | Suite location |
|------|---------------|
| `authenticator` | `suites/authenticator/suite/` |
| `cheese` | `suites/cheese/suite/` |
| `device-config-client` | `suites/device-config-client/suite/` |
| `headsets-charge-indicator` | `suites/headsets-charge-indicator/suite/` |
| `lunar-client` | `suites/lunar-client/suite/` |
| `TigerVNC` | `suites/TigerVNC/suite/` |

### Theme & Widgets (3)

| Snap | Suite location |
|------|---------------|
| `gtk-theme-pop` | `suites/gtk-theme-pop/suite/` |
| `gtk-theme-traditionalhumanized` | `suites/gtk-theme-traditionalhumanized/suite/` |
| `yaru-widgets-example` | `suites/yaru-widgets-example/suite/` |

### Media & Entertainment (6)

| Snap | Suite location |
|------|---------------|
| `geforce-now` | `suites/geforce-now/suite/` |
| `midnightmareteddy` | `suites/midnightmareteddy/suite/` |
| `super-cool-app` | `suites/super-cool-app/suite/` |
| `Transporter` | `suites/Transporter/suite/` |
| `Warble` | `suites/Warble/suite/` |
| `Widelands` | `suites/Widelands/suite/` |

### System & Utilities (2)

| Snap | Suite location |
|------|---------------|
| `neofetch-desktop` | `suites/neofetch-desktop/suite/` |
| `white-house` | `suites/white-house/suite/` |

---

**Total: 74 test suites covering all your snap repositories! 🎉**
