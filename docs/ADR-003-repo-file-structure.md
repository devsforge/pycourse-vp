# ADR-003: Repository File Structure

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

| ver. | Date       | Author                                    | Changes description                       |
|------|------------|-------------------------------------------|-------------------------------------------|
| 0.8  | 2026-01-26 | Serhii Horodilov                          | Fix typos                                 |
| 0.7  | 2026-01-26 | Claude Sonnet 4.5 <noreply@anthropic.com> | Complete final draft with decision        |
| 0.6  | 2026-01-26 | Serhii Horodilov                          | Replace `locales/**` with `content/**`    |
| 0.5  | 2026-01-26 | Serhii Horodilov                          | Add `upstream` repository link            |
| 0.4  | 2026-01-25 | Serhii Horodilov                          | Fix typos                                 |
| 0.3  | 2026-01-25 | Claude Sonnet 4.5 <noreply@anthropic.com> | Reframe as ru localization, add pictures/ |
| 0.2  | 2026-01-25 | Serhii Horodilov                          | Fix typos                                 |
| 0.1  | 2026-01-25 | Claude Sonnet 4.5 <noreply@anthropic.com> | Initial draft                             |

</details>

## Context

The repository currently contains legacy Russian-language content scattered across multiple locations alongside modern
project infrastructure. This creates organizational and discoverability issues:

**Current State:**

- **Legacy content at root**: All `*.md` files in root directory (except `AGENTS.md` and `CLAUDE.md`) are legacy
  Russian-language lesson files
- **Legacy assets scattered**: `/pictures/lesson01/`, `/pictures/lesson02/`, `/pictures/lesson08/` contain images tied
  to legacy Russian lessons
- **Modern content**: Structured English/Ukrainian content in `/src/` directory
- **Active assets**: All files in `/assets/` directory are actively used by current course content
- **Infrastructure files**: `.ai/`, `docs/`, `templates/`, `mindmaps/` at root
- **Configuration files**: Various dotfiles, and active files `AGENTS.md`, `CLAUDE.md` at root
- **Build artifacts location**: Undefined (Sphinx typically uses `_build/` but this may change with SSG)

**Problems:**

1. **Contributor confusion**: New contributors face unclear directory purpose — where should new content go?
2. **Repository clutter**: Root directory contains many legacy content files mixed with infrastructure
3. **Discoverability issues**: Hard to distinguish current vs. legacy content at a glance (only exceptions are
   `AGENTS.md` and `CLAUDE.md`)
4. **Scattered legacy content**: Russian lesson files at root, related images in `/pictures/lessonXX/` subdirectories —
   content and assets not colocated
5. **Incomplete localization structure**: No clear locale organization (`en-US`, `uk-UA`, `ru`) for multilingual
   project
6. **Maintenance overhead**: Legacy files require consideration during restructuring or tooling changes
7. **Onboarding friction**: New contributors must understand historical context to navigate repository
8. **Historical preservation**: Legacy Russian content lacks a clear "archived but preserved" status

**Historical Context:**

The legacy Russian-language files are from the original course version (the upstream source). The project has since
been translated to English with Ukrainian support, and content has been reorganized into `/src/`. The legacy files were
kept in place during initial translation work but have not been organized as a complete, preserved historical artifact
representing the original `ru` localization.

> [!IMPORTANT]
> This decision is interdependent with ADR-002 (SSG Replacement). The chosen SSG may have expectations about content
> location (e.g., `docs/`, `content/`, `src/`), and conversely, the structure decision affects SSG migration effort.

## Decision Drivers

- **Contributor clarity**: Make it obvious where current content lives and where new files should be added
- **Historical preservation**: Maintain complete legacy Russian content as historical artifact
- **Localization clarity**: Establish clear locale-based organization (`en-US`, `uk-UA`, `ru`)
- **Maintainability**: Reduce a cognitive load when navigating repository structure
- **Discoverability**: Clear separation between current and historical content
- **Content-asset colocation**: Keep related lesson content and images together
- **Build system compatibility**: Structure should support current and future SSG expectations
- **Git history preservation**: Maintain git history through move operations
- **Respectful treatment**: Honor the original Russian course as the foundation of the project

## Considered Options

### Option 1: Organize as `content/ru/` (Legacy Localization)

**Description**: Create a `content/ru/` directory structure that preserves all legacy Russian content (root `*.md`
files and `/pictures/lessonXX/` assets) as complete, self-contained localization. This treats the original Russian
course respectfully as a preserved historical artifact while clearly separating it from active English/Ukrainian
content.

**Pros**:

- **Respectful preservation**: Honors original Russian course as project foundation
- **Complete artifact**: Colocates lesson files with their images in a single locale directory
- **Clear localization model**: Establishes a pattern for future locale organization
- **Git history maintained**: Uses `git mv` to preserve full history
- **Historical reference**: Easy-to-browse complete original course structure
- **No data loss**: Everything preserved in an organized, discoverable location
- **Future-compatible**: If `ru` support is ever revived, content is ready
- **Clean separation**: Root becomes infrastructure-only, locales contain all content variations

**Cons**:

- **Repository size unchanged**: All legacy content remains (though organized)
- **Implementation effort**: Requires careful restructuring of both files and assets
- **Migration complexity**: Need to ensure paths and references are updated if any cross-references exist

**Structure Example**:

```
content/
  ru/              # Legacy Russian (preserved, not maintained)
    lessons/
      lesson*.md
      module*.md
    pictures/      # All pictures/lessonXX/ directories
      lesson01/
      lesson02/
      lesson08/
    README.md      # Explains this is legacy/historical
  (Future: en/, uk/ if locale-based organization adopted)
```

### Option 2: Organize as `_archive/ru/` (Archived Localization)

**Description**: Similar to Option 1, but uses `_archive/` prefix to more explicitly signal "not for active use."
Creates `_archive/ru/` containing all legacy Russian content.

**Pros**:

- **Explicit "archived" status**: Underscore prefix convention clearly signals historical content
- **Complete preservation**: All benefits of Option 1 regarding colocation and history
- **Prevents accidental modification**: Clear visual signal this content is frozen
- **Git history maintained**: Uses `git mv` operations

**Cons**:

- **Less elegant than `content/`**: Archive structure doesn't map to standard i18n patterns
- **Harder to revive**: If `ru` support returns, content is in "archive" not "locales"
- **Repository size unchanged**: All legacy content remains

**Structure Example**:

```
_archive/
  ru/
    lessons/
    pictures/
    README.md
```

### Option 3: Delete Legacy Content with Documentation

**Description**: Remove all legacy Russian content (root `*.md` files and `/pictures/lessonXX/` directories) from the
repository. Create `docs/LEGACY.md` documenting where original content can be found (upstream repo, git history).

**Pros**:

- **Cleanest repository**: Smallest repo size, zero legacy content
- **Reduced complexity**: No need to navigate historical content
- **Simplest long-term maintenance**: Only active content in the repository

**Cons**:

- **Loss of easy reference**: Content only accessible via git history or upstream
- **Historical context lost**: Harder to understand project evolution
- **Requires external navigation**: Must go to upstream or git history to see original
- **Less respectful**: Treats original course as disposable rather than foundational
- **Irreversible without effort**: Recovery requires git revert or upstream reference

### Option 4: Keep As-Is with README Clarification

**Description**: Maintain current structure but add clear documentation in README.md explaining legacy files and
directing contributors to `/src/` for active content.

**Pros**:

- **Zero implementation effort**: No file moves or restructuring
- **Git history intact**: No risk from file operations
- **Preserves everything in place**: All content immediately accessible

**Cons**:

- **Does not solve the core problem**: Repository remains cluttered
- **Ongoing confusion**: Visual clutter persists regardless of documentation
- **Scattered content**: Lesson files at root, images in subdirectories
- **Maintenance burden continues**: Legacy files remain consideration during changes
- **No localization structure**: Misses an opportunity to establish i18n patterns

### Option 5: Comprehensive Locale Reorganization

**Description**: Beyond handling legacy content, reorganize ALL content (including active `/src/`) into locale-based
structure: `content/en/`, `content/uk/`, `content/ru/`. This is the most comprehensive approach.

**Pros**:

- **Complete i18n structure**: Establishes proper multilingual organization
- **Consistent pattern**: All localizations use same structure
- **Scalable**: Easy to add future locales
- **Best long-term structure**: Industry-standard i18n organization

**Cons**:

- **Largest scope**: Affects ALL content, not just legacy
- **Breaking changes**: Major updates to a build system, references, documentation
- **SSG dependency**: Should coordinate with ADR-002 decision
- **High implementation risk**: Complex migration affecting active content
- **Timing concern**: Premature before SSG decision
- **May conflict with SSG expectations**: Some SSGs have their own locale conventions

## Decision

**Adopt Option 1: Organize as `content/ru/` (Legacy Localization)**

**Rationale:**

Option 1 provides the best balance of respectful historical preservation, clear organization, and future flexibility.
This decision is driven by the following factors:

1. **Respectful Treatment of Origins**: The original Russian course is the foundation of this project.
   Organizing it as complete, preserved localization honors that history while clearly marking it as legacy content.

2. **Complete Historical Artifact**: Colocating all Russian lesson files with their related images creates a
   self-contained, browsable historical reference. Contributors can understand project evolution without navigating
   git history or external repositories.

3. **Clear Separation**: Moving legacy content out of root eliminates contributor confusion. Root becomes
   infrastructure-only (`.ai/`, `docs/`, `templates/`, config files), making it obvious where to add new content.

4. **Git History Preservation**: Using `git mv` operations maintains full commit history for all files, preserving
   attribution and evolution tracking.

5. **Localization Foundation**: `content/ru/` establishes a pattern for potential future locale organization. While
   comprehensive locale reorganization (Option 5) is deferred pending ADR-002, this creates a foundation without
   premature commitment.

6. **Content-Asset Colocation**: Keeping lesson files together with their images in `content/ru/lessons/` and
   `content/ru/pictures/` improves discoverability and reduces maintenance burden.

7. **No Data Loss**: All legacy content is preserved and easily accessible, avoiding the irreversibility concerns of
   Option 3 (deletion).

8. **Flexibility for Revival**: If Russian localization support is revived in the future, content is already organized
   in a locale structure rather than buried in an "archive."

**Why Not Other Options:**

- **Option 2 (_archive/ru/)**: While explicit, the "archive" framing is less elegant and doesn't align with potential
  future i18n structure. `content/ru/` is more respectful and flexible.
- **Option 3 (Delete)**: Too aggressive. Loses easy reference to the original course and treats foundational work as
  disposable. Historical context is valuable.
- **Option 4 (Keep As-Is)**: Does not solve any problem. Documentation alone won't eliminate visual clutter or
  contributor confusion.
- **Option 5 (Comprehensive Reorganization)**: Premature and high risk. Should wait for ADR-002 decision on SSG, which
  will inform the optimal active content structure.

**Coordination with ADR-002:**

This decision is compatible with the MkDocs adoption in ADR-002. MkDocs uses configurable `docs_dir` setting and
doesn't impose rigid directory requirements. The legacy `content/ru/` structure won't interfere with active content
organization for MkDocs migration.

**Scope Boundaries:**

This decision addresses **only** legacy Russian content organization. Active English/Ukrainian content in `/src/`
remains unchanged pending ADR-002 finalization. Comprehensive locale reorganization (moving `/src/` to `content/en/`
and `content/uk/`) is explicitly deferred until SSG migration is complete.

## Consequences

### Positive

- **Clean Repository Root**: Root directory contains only infrastructure (`.ai/`, `docs/`, `templates/`, `mindmaps/`)
  and configuration files, eliminating 45+ scattered lesson files.
- **Clear Contributor Onboarding**: New contributors immediately understand where to add content (active content in
  `/src/`, legacy in `content/ru/`).
- **Historical Preservation**: Complete Russian course preserved as a self-contained artifact, easily browsable without
  git history navigation.
- **Respectful Treatment**: Original course honored as project foundation rather than discarded or hidden.
- **Git History Maintained**: Full commit history preserved for all moved files, maintaining attribution.
- **Content-Asset Colocation**: Related lesson files and images kept together, reducing maintenance burden.
- **Localization Foundation**: Establishes a pattern for potential future locale organization without premature
  commitment.
- **Reduced Cognitive Load**: Clear separation between active and legacy content simplifies mental model.
- **Easy Revival Path**: If Russian support returns, content is already in the locale structure.
- **No Data Loss**: All legacy content preserved and accessible.

### Negative

- **One-Time Migration Effort**: Requires careful file moves and README creation.
  Estimated 2--3 hours for execution and verification.
- **Repository Size Unchanged**: All legacy content remains in the repository (though organized). Repository size isn’t
  reduced.
- **Git History Shows Moves**: Git log shows move operations, though full history is preserved via `git log --follow`.
- **Potential Reference Updates**: If any cross-references exist between legacy and active content, they may need
  updating (though unlikely given content separation).
- **Learning Curve for Existing Contributors**: Contributors familiar with root-level legacy files need to update
  mental model.

### Neutral

- **Directory Structure Change**: Repository layout changes but functionality unaffected.
- **Active Content Unchanged**: `/src/` directory and all active content remain as-is (pending ADR-002).
- **Build System Unaffected**: Current Sphinx build process unaffected by legacy content relocation.
- **Future Flexibility**: Doesn't commit to or prevent comprehensive locale reorganization in the future.

## Implementation

### Phase 1: Preparation (30 minutes)

**Objective**: Validate approach and prepare for migration.

**Tasks**:

1. **Create Feature Branch**:
    - Create branch: `feature/organize-legacy-content`
    - Ensures `main` branch remains stable during reorganization

2. **Audit Legacy Content**:
    - List all root `*.md` files (excluding `AGENTS.md`, `CLAUDE.md`)
    - Verify `/pictures/lesson01/`, `/pictures/lesson02/`, `/pictures/lesson08/` contain only legacy images
    - Confirm no active content depends on legacy files

3. **Verify No Cross-References**:
    - Search for references to legacy files in `/src/` directory
    - Confirm no build process dependencies on root-level lesson files
    - Identify any documentation that references root-level content

**Deliverables**:

- Feature branch created
- Legacy content inventory
- Cross-reference verification report

### Phase 2: Directory Structure Creation (15 minutes)

**Objective**: Create a target directory structure.

**Tasks**:

1. **Create Directory Structure**:
   ```bash
   mkdir -p content/ru/lessons
   mkdir -p content/ru/pictures
   ```

2. **Create README**:
    - Create `content/ru/README.md` explaining:
        - This is the original Russian course (legacy, preserved for historical reference)
        - Not actively maintained
        - Represents project foundation and historical artifact
        - Active course is in `/src/` (English/Ukrainian)
        - Link to upstream repository for context

**Deliverables**:

- `content/ru/` directory structure
- `content/ru/README.md` with clear explanation

### Phase 3: Content Migration (45 minutes)

**Objective**: Move legacy content to a new structure.

**Tasks**:

1. **Move Lesson Files**:
   ```bash
   git mv lesson*.md content/ru/lessons/
   git mv module*.md content/ru/lessons/
   # Move any other root-level Russian lesson files
   ```
    - Verify all legacy `*.md` files moved (excluding `AGENTS.md`, `CLAUDE.md`)
    - Confirm git history preserved: `git log --follow content/ru/lessons/lesson01.md`

2. **Move Legacy Images**:
   ```bash
   git mv pictures/lesson01/ content/ru/pictures/
   git mv pictures/lesson02/ content/ru/pictures/
   git mv pictures/lesson08/ content/ru/pictures/
   ```
    - Verify all legacy picture directories moved
    - Confirm `/pictures/` is now empty (or remove if empty)

3. **Verify Moves**:
    - Check `git status` shows moves, not deletions/additions
    - Verify no unintended files moved
    - Confirm root directory now clean of legacy lesson files

**Deliverables**:

- All legacy content moved to `content/ru/`
- Clean the root directory (only infrastructure and config)
- Git history preserved

### Phase 4: Documentation Updates (30 minutes)

**Objective**: Update project documentation to reflect new structure.

**Tasks**:

1. **Update Root README.md**:
    - Add a section explaining repository structure
    - Clarify where active content lives (`/src/`)
    - Note legacy Russian content in `content/ru/` for historical reference
    - Direct contributors to `/src/` for new content

2. **Update Contributor Documentation**:
    - If `CONTRIBUTING.md` or similar exists, update with new structure
    - Clarify legacy content policy (preserved but not maintained)
    - Provide clear guidance on where to add new content

3. **Update `.ai/config.yaml`**:
    - Add `content/ru/` to file index if appropriate
    - Update any references to legacy file locations
    - Ensure AI agents understand new structure

4. **Check Other Documentation**:
    - Review `docs/` directory for any references to root-level legacy files
    - Update any file location references
    - Ensure no broken links or outdated information

**Deliverables**:

- Updated root `README.md`
- Updated contributor documentation
- Updated `.ai/config.yaml`
- All documentation references current

### Phase 5: Verification and Testing (30 minutes)

**Objective**: Ensure migration is successful and nothing is broken.

**Tasks**:

1. **Directory Structure Check**:
    - Verify `content/ru/lessons/` contains all legacy lesson files
    - Verify `content/ru/pictures/` contains all legacy image directories
    - Confirm root directory clean (only `AGENTS.md`, `CLAUDE.md`, infrastructure)
    - Verify `content/ru/README.md` exists and is accurate

2. **Git History Verification**:
    - Test `git log --follow` on several moved files
    - Confirm full history accessible
    - Verify moves shown as renames, not deletions

3. **Build System Check**:
    - Run the current Sphinx build process
    - Confirm build successful (legacy content not in builds)
    - Verify `/src/` content unaffected

4. **Cross-Reference Check**:
    - Search for any broken references in documentation
    - Verify no unexpected impacts on active content
    - Check for any orphaned files

**Deliverables**:

- Verification checklist completed
- Build confirmation
- No broken references are identified

### Phase 6: Commit and Review (30 minutes)

**Objective**: Finalize changes and prepare for merge.

**Tasks**:

1. **Create Comprehensive Commit**:
    - Commit message:
      ```
      docs: organize legacy Russian content into content/ru/
      
      Move all legacy Russian lesson files and related images from root
      directory to content/ru/ structure for clear organization and
      historical preservation.
      
      Changes:
      - Move lesson*.md and module*.md files to content/ru/lessons/
      - Move pictures/lessonXX/ directories to content/ru/pictures/
      - Create content/ru/README.md explaining legacy status
      - Update root README.md with new structure information
      - Update contributor documentation
      - Update .ai/config.yaml references
      
      Implements ADR-003: Repository File Structure (Option 1)
      Git history preserved via git mv operations.
      ```

2. **Self-Review**:
    - Review diff to confirm only intended changes
    - Verify commit message accurate
    - Check no unintended files included

3. **Push and Create PR** (or direct merge depending on workflow):
    - Push feature branch
    - Create a pull request with ADR-003 context
    - Link to ADR-003 in PR description
    - Request review if appropriate

**Deliverables**:

- Committed changes with a descriptive message
- Pull request created (or ready for direct merge)

### Success Criteria

Migration is considered successful when:

- [ ] All legacy Russian lesson files moved to `content/ru/lessons/`
- [ ] All legacy picture directories moved to `content/ru/pictures/`
- [ ] The root directory contains only infrastructure and config files
- [ ] `content/ru/README.md` clearly explains legacy status
- [ ] Root `README.md` updated with structure information
- [ ] `.ai/config.yaml` updated with new paths
- [ ] Git history preserved for all moved files (verified with `git log --follow`)
- [ ] The current Sphinx build process is unaffected
- [ ] No broken references in documentation
- [ ] Changes committed with a clear message
- [ ] Project Owner approves structure

### Estimated Timeline

**Total: 2--3 hours** (conservative estimate including verification)

- Phase 1: 30 minutes
- Phase 2: 15 minutes
- Phase 3: 45 minutes
- Phase 4: 30 minutes
- Phase 5: 30 minutes
- Phase 6: 30 minutes

### Risks and Mitigations

| Risk                  | Impact | Mitigation                                                    |
|-----------------------|--------|---------------------------------------------------------------|
| Unintended file moves | Medium | Careful verification in Phase 3; feature branch protects main |
| Git history loss      | High   | Use `git mv` exclusively; verify with `--follow` in Phase 5   |
| Broken references     | Low    | Cross-reference audit in Phase 1; verification in Phase 5     |
| Build system breakage | Low    | Build test in Phase 5; legacy content not in build path       |
| Contributor confusion | Low    | Clear documentation updates in Phase 4                        |

### Rollback Plan

If critical issues emerge:

1. Feature branch (`feature/organize-legacy-content`) keeps `main` branch intact
2. Can abandon the branch and revert to the current structure
3. Git history preserved means the original state is always recoverable
4. No changes to `main` branch until migration fully validated

## Related

- [ADR-002][ADR-002]: Static Site Generator Replacement (interdependent, SSG may have i18n expectations)
- [ADR-004][ADR-004]: Presentation Framework Handling (may affect assets directory organization)
- [ADR-001][ADR-001]: AI Guidelines Structure and Administration Framework
- [Upstream repository][upstream]: Original work by @PonomaryovVladyslav and contributors

[//]: # (@formatter:off)
<!-- ADR references -->
[ADR-001]: ./ADR-001-ai-guidelines-structure.md
[ADR-002]: ./ADR-002-ssg-replacement.md
[ADR-003]: ./ADR-003-repo-file-structure.md
[ADR-004]: ./ADR-004-presentation-framework.md
<!-- upstream repository -->
[upstream]: https://github.com/PonomaryovVladyslav/PythonCourses.git
[//]: # (formatter:on)
