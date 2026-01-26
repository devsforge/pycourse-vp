# ADR-004: Presentation Framework Handling

[//]: # (@formatter:off)
<!-- document status badges -->
[draft]: https://img.shields.io/badge/document_status-draft-orange.svg
[accepted]: https://img.shields.io/badge/document_status-accepted-green.svg
[deprecated]: https://img.shields.io/badge/document_status-deprecated-lightgrey.svg
[rejected]: https://img.shields.io/badge/document_status-rejected-red.svg
[final]: https://img.shields.io/badge/document_status-final-blue.svg
[//]: # (@formatter:on)
![status][draft]

<details>
<summary>Document Changelog</summary>

[//]: # (order by version number descending)

| ver. | Date       | Author                                    | Changes description |
|------|------------|-------------------------------------------|---------------------|
| 0.2  | 2026-01-25 | Serhii Horodilov                          | Fix links and typos |
| 0.1  | 2026-01-25 | Claude Sonnet 4.5 <noreply@anthropic.com> | Initial draft       |

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

**[DECISION PENDING - DRAFT STATUS]**

**Critical First Step**: Determine whether impress.js presentations are actively used in current course delivery:

1. **Search for usage**: Check `/src/` for any `.html` files or references to impress.js
2. **Review course structure**: Confirm if presentations are part of pedagogy
3. **Consult project history**: Determine if presentations were legacy Russian course feature

**Recommended decision based on usage:**

- **If NOT actively used**: **Option 2** (Remove and Use CDN)
    - Cleanest solution with maximum benefit
    - CDN fallback available if presentations are added later
    - Dramatic repository size reduction

- **If actively used but infrequently**: **Option 2** (Remove and Use CDN) or **Option 5** (npm Dependency)
    - CDN is simpler if just serving HTML presentations
    - npm is better if presentations are built/compiled

- **If actively used extensively**: **Option 5** (npm Dependency)
    - Proper dependency management
    - Version control and update path clear

Decision should be made after:

1. Confirming current usage of impress.js in course materials
2. Understanding presentation requirements (if any) for course delivery
3. Assessing whether a CDN-based approach meets all needs

## Consequences

**[TO BE DETERMINED AFTER DECISION]**

General consequence categories based on likely options:

### Positive (if Option 2 or 5 is chosen)

- Dramatic repository size reduction (95%+ of assets directory)
- Faster clone times for all contributors
- Modern dependency management approach
- Clearer project structure
- Reduced maintenance burden

### Negative (if Option 2 is chosen)

- Requires internet for presentations (minor - course is web-delivered)
- Migration effort for existing presentation HTML (if any)
- External dependency on CDN

### Negative (if Option 5 is chosen)

- Requires build tooling setup
- Additional complexity in the development workflow
- Learning curve for contributors unfamiliar with npm

### Neutral

- No impact on course content if presentations are not used
- Potential for future presentation features remains open

## Implementation

**[TO BE DEFINED AFTER DECISION]**

Potential implementation for each option:

**Option 1 (Keep As-Is):**

1. Document why local copy is necessary
2. Establish an update schedule if actively maintained
3. Accept repository size impact

**Option 2 (Remove and Use CDN):**

1. Search repository for impress.js usage:
   ```bash
   find . -name "*.html" -exec grep -l "impress" {} \;
   ```
2. If presentations exist, update HTML to use CDN:
   ```html
   <script src="https://cdn.jsdelivr.net/gh/impress/impress.js@2.0.0/js/impress.js"></script>
   ```
3. Remove directory:
   ```bash
   git rm -r assets/impress.js/
   ```
4. Update documentation noting CDN usage for presentations

**Option 3 (Extract to Separate Repository):**

1. Create new repository: `pymastery-presentations`
2. Move impress.js with history:
   ```bash
   git subtree split --prefix=assets/impress.js/ -b presentations-only
   ```
3. Push to a new repository
4. Remove from the main repository
5. Document in README how to access presentations repository if needed

**Option 4 (Archive):**

1. Create `_archive/` directory
2. Move impress.js:
   ```bash
   git mv assets/impress.js/ _archive/impress.js/
   ```
3. Create `_archive/README.md` explaining archived content
4. Update root README to note archive location

**Option 5 (npm Dependency):**

1. Initialize package.json if not exists:
   ```bash
   npm init -y
   ```
2. Add impress.js as a dependency:
   ```bash
   npm install --save impress.js
   ```
3. Set up build tooling (webpack/rollup/etc.) if needed
4. Update HTML to reference a bundled version
5. Remove `/assets/impress.js/` directory:
   ```bash
   git rm -r assets/impress.js/
   ```
6. Update documentation on development workflow

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
