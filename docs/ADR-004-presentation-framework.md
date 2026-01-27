# ADR-004: Presentation Framework Handling

[//]: # (@formatter:off)
<!-- document status badges -->
[draft]: https://img.shields.io/badge/document_status-draft-orange.svg
[accepted]: https://img.shields.io/badge/document_status-accepted-green.svg
[deprecated]: https://img.shields.io/badge/document_status-deprecated-lightgrey.svg
[rejected]: https://img.shields.io/badge/document_status-rejected-red.svg
[final]: https://img.shields.io/badge/document_status-final-blue.svg
[//]: # (@formatter:on)
![status][accepted]

<details>
<summary>Document Changelog</summary>

[//]: # (order by version number descending)

| ver. | Date       | Author                                    | Changes description  |
|------|------------|-------------------------------------------|----------------------|
| 0.3  | 2026-01-26 | Claude Sonnet 4.5 <noreply@anthropic.com> | Complete final draft |
| 0.2  | 2026-01-25 | Serhii Horodilov                          | Fix links and typos  |
| 0.1  | 2026-01-25 | Claude Sonnet 4.5 <noreply@anthropic.com> | Initial draft        |

</details>

## Context

The repository currently contains the complete impress.js presentation framework in `/assets/impress.js/`, representing
approximately 95%+ of the assets directory size. This creates significant repository bloat and raises questions about
necessity and maintenance.

**Current State:**

- **Location**: `/assets/impress.js/` directory at repository root
- **Size**: Extremely large (~33,000+ lines in directory tree alone)
- **Contents**: Complete impress.js library including:
    - Source code and build system
    - Package management files (package.json, package-lock.json)
    - Multiple example presentations
    - Extensive plugin ecosystem
    - Test suites
    - Localization files for multiple languages
    - Documentation
    - Full dependency tree
- **Active assets**: All other files in `/assets/` directory (icons, images, mermaid diagrams) are actively used
- **Impact**: Repository size and clone time are significantly affected by this single directory

**Current Usage (To Be Determined):**

- **Unknown**: Whether impress.js presentations are actively used in course delivery
- **Unknown**: Whether any course content depends on this local copy vs. CDN version
- **Unknown**: Whether build process or development workflow requires local copy

**Problems:**

1. **Repository bloat**: Single directory dominates repository size
2. **Clone time**: Slower repository cloning for all contributors
3. **Maintenance overhead**: Requires keeping a library updated if actively used
4. **Unclear necessity**: No clear documentation of why local copy is required vs. CDN
5. **Development friction**: Large directory size slows down file system operations
6. **Backup inefficiency**: Repository backups are unnecessarily large

**Historical Context:**

The impress.js framework was likely added for creating presentation-style course materials or demos. However, it's
unclear whether this feature is actively used in the current course structure or if presentations were part of the
legacy Russian version that has since been deprecated.

> [!IMPORTANT]
> This decision may impact ADR-002 (SSG Replacement) if presentations are part of course delivery requirements.

## Decision Drivers

- **Repository size**: Impact on clone time, storage, and contributor experience
- **Active usage**: Whether presentations are part of the current course delivery
- **Maintenance burden**: Effort required to keep a library updated vs. benefits
- **Dependency management**: Best practices for managing third-party libraries
- **Build requirements**: Whether a local copy is needed for a build process vs. runtime
- **Alternative approaches**: CDN usage, npm package management, separate repositories
- **Course delivery needs**: Requirements for presentation-style content

## Considered Options

### Option 1: Keep As-Is (Full Local Copy)

**Description**: Maintain the current `/assets/impress.js/` directory with a complete library in the repository.

**Pros**:

- **No migration needed**: Zero implementation effort
- **Self-contained**: Works offline, no external dependencies
- **Version locked**: Guaranteed compatibility with a frozen version
- **No breaking changes**: Existing presentations (if any) work unchanged

**Cons**:

- **Massive repository bloat**: 95%+ of the assets directory is a single library
- **Slow clones**: Every contributor downloads an entire presentation framework
- **Maintenance burden**: Must manually update a library for security/features
- **No clear justification**: Benefits unclear if presentations are rarely/never used
- **Poor dependency management**: Violates modern best practices (use package managers)

### Option 2: Remove and Use CDN

**Description**: Delete `/assets/impress.js/` directory entirely. If presentations are needed, reference impress.js
from a CDN (e.g., cdnjs, jsDelivr) in HTML files.

**Pros**:

- **Dramatic size reduction**: Removes 95%+ of the assets directory
- **Faster clones**: Significantly improved contributor experience
- **Automatic updates**: CDN provides latest stable version
- **Best practice**: Standard approach for client-side libraries
- **No maintenance**: No need to update the library manually
- **Better caching**: Users benefit from shared CDN cache across sites

**Cons**:

- **Requires internet**: Won't work offline (though the course is web-delivered anyway)
- **External dependency**: Relies on CDN availability
- **Version changes**: CDN updates might break presentations (mitigated by version pinning)
- **Migration effort**: Update existing presentation HTML to reference CDN

> [!NOTE]
> Use version-pinned CDN URLs like:
> ```html
> <script src="https://cdn.jsdelivr.net/gh/impress/impress.js@2.0.0/js/impress.js"></script>
> ```

### Option 3: Extract to Separate Repository

**Description**: Move `/assets/impress.js/` to a separate repository (e.g., `pymastery-presentations`). Main course
repo references it as a git submodule or documents how to clone separately if needed.

**Pros**:

- **Clean separation**: The main repo focuses on course content
- **Optional dependency**: Only those working on presentations clone it
- **Preserves history**: Git history for presentation development maintained
- **Flexible**: Can still use presentations without CDN
- **Modular**: Clear boundary between course and presentation tooling

**Cons**:

- **Complexity**: Adds git submodule or separate clone step
- **Maintenance**: Now managing two repositories
- **Coordination**: Changes across both repos require more planning
- **Overkill if unused**: Extra complexity for a potentially unused feature

### Option 4: Archive to `_archive/impress.js/`

**Description**: Move `/assets/impress.js/` to `_archive/impress.js/` to signal it's historically/not actively used,
but preserve it in repository.

**Pros**:

- **Preserves history**: Library remains in repository for reference
- **Clearer status**: Archive location signals "not for active use"
- **Git history intact**: Move operation preserves full history
- **Easy recovery**: Can restore if needed

**Cons**:

- **Doesn't solve bloat**: Repository size unchanged
- **Unclear benefit**: If not used, why keep it?
- **Maintenance still unclear**: Archive status doesn't eliminate update question

### Option 5: Convert to npm Dependency

**Description**: Remove `/assets/impress.js/` directory. If presentations are actively used, add impress.js as a npm
dependency in `package.json` and use build tools to bundle it.

**Pros**:

- **Modern dependency management**: Uses npm ecosystem properly
- **Version control**: Exact version pinning in package.json
- **Automated updates**: npm tools for dependency management
- **Build-time bundling**: Include only what's needed
- **Developer-friendly**: Standard workflow for JavaScript projects

**Cons**:

- **Requires build tooling**: Need webpack/rollup/etc. if not already present
- **Complexity increase**: Build pipeline for asset management
- **Overkill if simple**: May be unnecessary if just serving static HTML
- **Learning curve**: Contributors need to understand a build process

## Decision

**Decision:** **Option 5 (npm Dependency)** - Lowest-effort implementation

**Findings:**

After verification, exactly **one presentation exists** in the repository at `src/rdbms/presentations/`.

**Rationale:**

1. **Keep presentation in the main repository**: No need for a separate submodule or repository
2. **Remove vendored impress.js submodule**: Eliminates 95%+ of assets directory bloat (~33,000+ lines)
3. **Add impress.js as npm build dependency**: Modern dependency management using existing package.json
4. **Leverage existing webpack setup**: Zero new tooling required; webpack 5 already configured

**Why Option 5 (npm Dependency):**

- **Matches existing pattern**: Project already uses npm for dependencies (mermaid@10.8.0, webpack tooling)
- **Leverages existing infrastructure**: Webpack 5 + html-webpack-plugin already in place
- **Self-contained development**: Works offline (unlike the CDN approach in Option 2)
- **Version locked**: package-lock.json ensures consistency across environments
- **Minimal implementation effort**: Single line addition to package.json + HTML import update
- **Future-proof**: If more presentations are added, infrastructure is ready
- **Dramatic size reduction**: Removes 95%+ of the assets directory
- **Standard workflow**: Contributors already familiar with npm (mermaid pattern)

**Implementation Approach, Lowest Effort:**

1. Add `impress.js` as dependency to package.json (one line)
2. Update presentation HTML to import from the npm package (simple path change)
3. Remove git submodule at `/assets/impress.js/` (cleanup)
4. Existing webpack configuration handles bundling automatically (zero config changes)

**Estimated Implementation Time:** 5--10 minutes

**Dependencies Resolved:**

This decision removes the blocker for ADR-002 (SSG Replacement), as presentation requirements are now clarified and
asset organization is simplified.

## Consequences

**Based on Chosen Option 5 (npm Dependency):**

### Positive

- **Dramatic repository size reduction**: Removes 95%+ of the assets directory (~33,000+ lines from tree)
- **Faster clone times**: Significantly improved contributor onboarding experience
- **Modern dependency management**: Uses npm ecosystem properly, matches an existing mermaid pattern
- **Clearer project structure**: Assets directory contains only actual course assets
- **Reduced maintenance burden**: npm handles library updates via standard tooling
- **Version control**: Exact version pinning in package.json and package-lock.json
- **Self-contained development**: Works offline during development (unlike the CDN approach)
- **Minimal migration effort**: Leverages existing webpack configuration, zero new tooling
- **No learning curve**: Contributors already familiar with npm workflow from mermaid

### Negative

- **One-time migration effort**: ~5--10 minutes to update presentation HTML and remove submodule
- **Dependency added**: Project now has one additional npm dependency (minimal impact)
- **Build process required**: Presentation now requires `npm install` and webpack build (already required for mermaid
  and other assets)

### Neutral

- **No impact on course content**: Single presentation continues to work identically after migration
- **Future presentations enabled**: Infrastructure ready if more presentations are added
- **Webpack requirement unchanged**: Build tooling already in place for existing dependencies

## Implementation

**Chosen Implementation: Option 5 (npm Dependency), Lowest Effort Approach**

### Step-by-Step Implementation:

**1. Add impress.js as `npm` dependency:**

```bash
npm install impress.js --save
```

This updates `package.json`:

```json
{
    "dependencies": {
        "@mermaid-js/mermaid-cli": "^10.8.0",
        "mermaid": "^10.8.0",
        "impress.js": "^2.0.0"
        // New dependency
    }
}
```

**2. Update presentation HTML** (in `src/rdbms/presentations/`):

**Before** (vendored submodule reference):

```html

<script src="../../../assets/impress.js/js/impress.js"></script>
```

**After** (npm package reference):

*Option 2a: Direct import in HTML:*

```html

<script src="impress.js"></script>
```

*Option 2b: Create presentation.js entry point (recommended):*

```javascript
// src/rdbms/presentations/presentation.js
import 'impress.js';
```

Then reference in HTML:

```html

<script src="presentation.js"></script>
```

**3. Remove git submodule:**

```bash
git submodule deinit assets/impress.js
git rm assets/impress.js
rm -rf .git/modules/assets/impress.js
```

**4. Verify build:**

```bash
npm install
npm run build
```

Existing webpack configuration will automatically bundle impress.js with the presentation.

**5. Test presentation:**

```bash
npm start  # Development server
# OR
npm run build  # Production build
```

Navigate to the presentation location and verify impress.js functionality.

---

### Technical Details:

- **Webpack configuration**: No changes required, existing html-webpack-plugin handles bundling
- **Version pinning**: Locked to `impress.js@2.0.0` in package-lock.json
- **Build output**: Presentation HTML with bundled impress.js in the output directory
- **Development workflow**: `npm start` for dev server, `npm run build` for production

---

### Rollback Plan:

If issues arise, the presentation can temporarily reference CDN:

```html

<script src="https://cdn.jsdelivr.net/gh/impress/impress.js@2.0.0/js/impress.js"></script>
```

---

### Success Criteria:

- ✅ Repository size reduced by ~95% in the assets directory
- ✅ Presentation loads and functions correctly
- ✅ Build process completes without errors
- ✅ No git submodule references remain
- ✅ package.json and package-lock.json updated
- ✅ Contributors can clone and build without additional steps beyond standard `npm install`

## Related

- [ADR-002][ADR-002]: Static Site Generator Replacement (may affect presentation delivery approach)
- [ADR-003][ADR-003]: Repository File Structure (affects overall assets organization)
- [ADR-001][ADR-001]: AI Guidelines Structure and Administration Framework

[//]: # (@formatter:off)
<!-- ADR references -->
[ADR-001]: ./ADR-001-ai-guidelines-structure.md
[ADR-002]: ./ADR-002-ssg-replacement.md
[ADR-003]: ./ADR-003-repo-file-structure.md
[ADR-004]: ./ADR-004-presentation-framework.md
[//]: # (formatter:on)
