# ADR-002: Static Site Generator Replacement

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

| ver. | Date       | Author                                    | Changes description                |
|------|------------|-------------------------------------------|------------------------------------|
| 0.6  | 2026-01-26 | Serhii Horodilov                          | Fix typos                          |
| 0.5  | 2026-01-26 | Claude Sonnet 4.5 <noreply@anthropic.com> | Complete final draft with decision |
| 0.4  | 2026-01-25 | Serhii Horodilov                          | Fix typos                          |
| 0.3  | 2026-01-25 | Claude Sonnet 4.5 <noreply@anthropic.com> | Add ADR-004 cross-reference        |
| 0.2  | 2026-01-25 | Serhii Horodilov                          | Fix typos                          |
| 0.1  | 2026-01-25 | Claude Sonnet 4.5 <noreply@anthropic.com> | Initial draft                      |

</details>

## Context

The project currently uses Sphinx as its static site generator. While Sphinx is powerful and widely used for technical
documentation, several issues have emerged that motivate reconsidering this choice:

**Current Pain Points:**

- **Authoring complexity**: Sphinx requires reStructuredText (reST), which adds a learning curve for contributors
  compared to Markdown
- **Perceived overkill**: Sphinx's extensive feature set (designed for large technical documentation projects like
  Python's official docs) may exceed the project's actual needs
- **Contributor friction**: New contributors familiar with Markdown face an additional barrier when contributing
  content
- **Maintenance overhead**: reST syntax requires more careful formatting and is less forgiving than Markdown

**Current Setup:**

- Static site generator: Sphinx
- Content format: reStructuredText (.rst)
- Deployment target: GitHub Pages
- Localization: English (primary), Ukrainian (translation)
- Content location: `/src/` directory

**Project Requirements:**

- Must support English/Ukrainian localization workflow
- Must be compatible with GitHub Pages deployment
- Should prioritize Markdown authoring for contributor accessibility
- Should maintain professional documentation quality
- Should support code highlighting, admonitions, and other common documentation features

> [!IMPORTANT]
> This decision is interdependent with ADR-003 (Repository File Structure). The chosen SSG may have specific
> expectations about directory structure, and the migration effort will vary based on how legacy content is handled.

## Decision Drivers

- **Author experience**: Ease of writing and maintaining course content (Markdown vs. reST)
- **Contributor accessibility**: Lower barrier to entry for community contributions
- **Localization workflow**: Support for English/Ukrainian content with a maintainable translation process
- **Migration effort**: Feasibility of converting existing Sphinx/reST content to a new format
- **Feature completeness**: Support for documentation features needed by course content (admonitions, code blocks,
  cross-references, etc.)
- **GitHub Pages compatibility**: Deployment workflow simplicity
- **Community familiarity**: Common adoption in educational/documentation projects
- **Maintenance burden**: Long-term effort required to maintain the SSG setup
- **Build performance**: Site generation speed for rapid iteration during content development

## Considered Options

### Option 1: MkDocs with Material Theme

**Description**: MkDocs is a static site generator designed specifically for project documentation, with native
Markdown support and an extensive plugin ecosystem. The Material theme provides a modern UI and includes i18n support
via plugin.

**Pros**:

- Native Markdown support (CommonMark + extensions)
- Excellent documentation-focused design
- Active development and a strong community
- Material theme provides professional appearance out-of-box
- i18n plugin available for localization
- Simple configuration (single `mkdocs.yml` file)
- Good GitHub Pages integration
- Fast build times
- Lower a learning curve for contributors

**Cons**:

- i18n workflow is plugin-based (not a first-class feature)
- Less powerful than Sphinx for complex cross-referencing scenarios
- Localization workflow may require additional tooling/conventions
- Some advanced Sphinx features may not have direct equivalents

### Option 2: Docusaurus

**Description**: Facebook's modern documentation framework built on React, with first-class i18n support and optimized
for technical documentation sites.

**Pros**:

- First-class internationalization support (built-in, not plugin)
- Modern, polished UI with excellent UX
- MDX support (Markdown + React components) for interactive content
- Strong versioning support (useful if the course evolves)
- Very active development and community
- Excellent documentation and ecosystem
- Built-in search functionality
- Optimized performance (SPA architecture)

**Cons**:

- More complex than simpler SSGs (React-based)
- Requires Node.js ecosystem (additional dependency)
- Heavier build process
- Maybe overkill for linear course content
- Steeper learning curve for content authors who want to use React features

### Option 3: Hugo

**Description**: Fast, flexible static site generator written in Go, with strong i18n support and extensive theming
ecosystem.

**Pros**:

- Extremely fast build times (critical for large sites)
- First-class i18n support (built into Hugo core)
- Single binary distribution (no runtime dependencies)
- Powerful templating system
- Large theme ecosystem
- Excellent documentation
- Mature and stable

**Cons**:

- Template syntax (Go templates) has a steeper learning curve
- More configuration required than MkDocs
- Primarily a general-purpose SSG (not documentation-specific)
- Content organization may require more manual setup
- Less opinionated than documentation-focused tools

### Option 4: Jekyll

**Description**: GitHub's native SSG with automatic GitHub Pages support and a simple Markdown-based workflow.

**Pros**:

- Native GitHub Pages integration (zero-config deployment)
- Ruby-based (familiar to some developers)
- Mature and stable
- Simple setup for basic sites
- Plugin ecosystem available

**Cons**:

- i18n support is plugin-based and less mature
- Slower build times compared to Hugo
- Less active development than newer alternatives
- Configuration can become complex for larger sites
- Not specifically designed for documentation

### Option 5: Keep Sphinx

**Description**: Maintain the current Sphinx setup, potentially with improvements to workflow or configuration.

**Pros**:

- No migration effort required
- Most powerful for technical documentation
- Excellent cross-referencing capabilities
- Very mature i18n/l10n support
- Widely used in the Python community

**Cons**:

- Retains all current pain points (reST, complexity)
- Higher contributor barrier
- Steeper learning curve
- More maintenance overhead
- Does not address core motivation for change

## Decision

**Adopt MkDocs with Material Theme (Option 1)**

**Rationale:**

`MkDocs` with `Material` theme provides the optimal balance of simplicity, contributor accessibility, and feature
completeness for this educational project. This decision is driven by the following factors:

1. **Primary Goal Achievement**: The main motivation for SSG replacement is reducing contributor friction. `MkDocs`
   delivers native Markdown support, eliminating the reST learning curve that motivated this change.

2. **Documentation-Specific Design**: Unlike general-purpose SSGs (Hugo, Jekyll), `MkDocs` is purpose-built for
   documentation projects, providing sensible defaults and conventions that align with course content structure.

3. **Maintainability**: Single `mkdocs.yml` configuration file and straightforward plugin system minimize long-term
   maintenance burden compared to Sphinx's complexity or Docusaurus's React ecosystem.

4. **Localization Support**: While i18n is plugin-based rather than first-class, the `mkdocs-static-i18n` plugin
   provides mature multilingual support sufficient for English/Ukrainian workflow. The plugin's approach is
   well-documented and actively maintained.

5. **GitHub Pages Integration**: Simple deployment workflow via `mkdocs gh-deploy` command or GitHub Actions, with no
   complex build pipeline required.

6. **Material Theme Quality**: Provides a professional, modern UI out-of-box with excellent mobile responsiveness and
   built-in search, dark mode, and navigation features.

7. **Community and Ecosystem**: Large, active community with extensive plugin ecosystem and excellent documentation.
   Widely adopted for educational and technical documentation projects.

8. **Migration Feasibility**: Pandoc-based conversion from reST to Markdown is well-established. Migration complexity
   is manageable and can be automated with scripting.

9. **Feature Coverage**: Supports all required documentation features (admonitions, code blocks with syntax
   highlighting, tabbed content, content tabs for code examples, custom CSS/JS when needed).

10. **Build Performance**: Fast build times suitable for iterative content development.

**Why Not Other Options:**

- **Docusaurus**: Excellent but overkill for linear course content. React dependency and MDX complexity exceed project
  needs. First-class i18n doesn't justify the heavier ecosystem.
- **Hugo**: Extremely fast but requires Go template knowledge for customization. General-purpose nature means more
  manual setup. Speed advantage is not critical for this project size.
- **Jekyll**: Native GitHub Pages support appealing but i18n support less mature. Slower builds and declining community
  momentum compared to alternatives.
- **Keep Sphinx**: Does not address the core motivation (reST complexity and contributor friction). Keeping Sphinx
  means accepting current pain points indefinitely.

**Coordination with ADR-003:**

MkDocs has flexible content organization and doesn't impose strict directory requirements. The decision in ADR-003 to
organize legacy content as `content/ru/` is fully compatible. MkDocs typically uses `docs/` as content root, but this
is configurable via `docs_dir` setting in `mkdocs.yml`.

## Consequences

### Positive

- **Improved Contributor Experience**: Markdown authoring significantly lowers a barrier to entry. Contributors
  familiar with GitHub wikis, README files, or other Markdown contexts can immediately write content.
- **Reduced Maintenance Burden**: Simpler configuration and fewer moving parts compared to Sphinx. Single `mkdocs.yml`
  file vs. Sphinx's `conf.py` and multiple configuration contexts.
- **Modern UI Out-of-Box**: Material theme provides a professional appearance with no customization required. Built-in
  features (search, navigation, dark mode) work immediately.
- **Faster Iteration**: Simpler build process and live-reload development server enable rapid content development and
  preview.
- **Better Alignment with Project Needs**: Documentation-focused tool matches educational content structure better than
  general-purpose SSGs or complex frameworks.
- **Strong Localization Support**: `mkdocs-static-i18n` plugin provides mature multilingual workflow adequate for
  English/Ukrainian content.
- **GitHub Pages Compatibility**: Simple deployment with `mkdocs gh-deploy` or GitHub Actions integration.
- **Active Community**: Large ecosystem of plugins and themes. Regular updates and strong documentation.
- **Markdown Portability**: Content in Markdown is more portable and reusable than proprietary reST syntax.

### Negative

- **Migration Effort**: One-time cost to convert existing Sphinx/reST content to MkDocs/Markdown format.
  Estimated 5--7 days for comprehensive migration including testing and refinement.
- **Feature Gaps**: Some advanced Sphinx features (sphinx-autodoc for Python API documentation, complex
  cross-referencing) have no direct equivalent. However, course content does not currently use these features.
- **Plugin Dependency for i18n**: Localization is plugin-based rather than a core feature.
  This adds one dependency, but the plugin is mature and actively maintained.
- **Learning Curve for Customization**: Team members familiar with Sphinx/Python will need to learn MkDocs conventions
  and YAML configuration.
- **Retraining Contributors**: Existing contributors familiar with reST will need to adapt to Markdown (though this is
  generally easier than the reverse).
- **Theme Lock-In**: Material theme is excellent, but switching themes in the future would require adjustment.
  However, the theme ecosystem is large and theme switching is possible if needed.

### Neutral

- **Different Plugin Ecosystem**: MkDocs plugins differ from Sphinx extensions. Some Sphinx extensions have MkDocs
  equivalents, others don't. Need to evaluate plugins case-by-case.
- **Build System Change**: CI/CD pipeline will need updates for new build command and Python dependencies (MkDocs,
  plugins).
- **Configuration Format Change**: YAML-based configuration vs. Python-based Sphinx conf.py. Neither is inherently
  better; just different.
- **Documentation Rewrite**: Contributor documentation will need updates to reflect Markdown authoring and MkDocs
  workflows.

## Implementation

### Phase 1: Preparation and Analysis (Day 1)

**Objective**: Establish migration foundation and validate approach.

**Tasks**:

1. **Audit Current Content**:
    - Inventory all `.rst` files in `/src/` and subdirectories
    - Identify Sphinx-specific directives and extensions used
    - Document custom Sphinx configurations from `conf.py`
    - List all images, assets, and cross-references

2. **Set Up MkDocs Test Environment**:
    - Create new branch: `feature/mkdocs-migration`
    - Install MkDocs and Material theme: `pip install mkdocs mkdocs-material`
    - Install i18n plugin: `pip install mkdocs-static-i18n`
    - Create initial `mkdocs.yml` configuration

3. **Validate Conversion Approach**:
    - Test Pandoc conversion on sample `.rst` files
    - Identify conversion patterns and edge cases
    - Document manual adjustments needed post-conversion

4. **Define Content Structure**:
    - Determine `docs_dir` location (coordinate with ADR-003 decision)
    - Plan directory structure for English/Ukrainian content
    - Define navigation structure in `mkdocs.yml`

**Deliverables**:

- Content audit document
- Test MkDocs environment on branch
- Pandoc conversion validation report
- Initial `mkdocs.yml` configuration

### Phase 2: Content Conversion (Days 2--3)

**Objective**: Convert reST content to Markdown format.

**Tasks**:

1. **Automated Conversion**:
    - Create a Pandoc conversion script for batch processing
    - Convert all `.rst` files to `.md` format
    - Preserve directory structure during conversion

2. **Manual Refinement**:
    - Review converted Markdown for accuracy
    - Fix Pandoc conversion artifacts (e.g., reference syntax, code blocks)
    - Adjust admonitions to Material theme syntax (`!!! note`, `!!! warning`)
    - Update internal links and cross-references
    - Verify image paths and asset references

3. **Content Quality Check**:
    - Build site with MkDocs: `mkdocs build`
    - Review generated HTML in a browser
    - Test all navigation links
    - Verify code syntax highlighting
    - Check responsive design on mobile

**Deliverables**:

- All content converted to Markdown format
- Pandoc conversion script (for future reference)
- Quality check report

### Phase 3: Localization Setup (Day 4)

**Objective**: Configure multilingual support for English/Ukrainian content.

**Tasks**:

1. **Configure `mkdocs-static-i18n` Plugin**:
    - Add plugin to `mkdocs.yml`
    - Define locales: `en` (default), `uk`
    - Set up the locale structure according to plugin conventions

2. **Organize Translated Content**:
    - Structure English content in the default location
    - Organize Ukrainian translations according to plugin requirements
    - Verify language switcher functionality

3. **Configure Navigation Per Locale**:
    - Define navigation structure for each language
    - Test language switching in built site
    - Verify all links work in both locales

**Deliverables**:

- Configured i18n plugin
- Working language switcher
- Both English and Ukrainian contents are accessible

### Phase 4: Theme Customization and Features (Day 5)

**Objective**: Customize Material theme and configure additional features.

**Tasks**:

1. **Material Theme Configuration**:
    - Configure theme colors, fonts, and logo
    - Enable Material theme features (tabs, instant loading, dark mode)
    - Set up a search plugin configuration

2. **Additional Plugins**:
    - Evaluate and configure useful plugins (e.g., `mkdocs-minify-plugin`, `mkdocs-git-revision-date-localized-plugin`)
    - Test plugin compatibility with i18n

3. **Custom Styling** (if needed):
    - Create `docs/stylesheets/extra.css` for project-specific styles
    - Add custom JavaScript if needed (`docs/javascripts/extra.js`)

4. **Feature Testing**:
    - Test search functionality in both languages
    - Verify dark mode
    - Test navigation features (tabs, instant loading)
    - Mobile responsiveness check

**Deliverables**:

- Fully customized Material theme
- Configured additional plugins
- Feature validation report

### Phase 5: CI/CD and Deployment (Days 6--7)

**Objective**: Set up automated build and deployment to GitHub Pages.

**Tasks**:

1. **Update Dependencies**:
    - Create/update `requirements.txt` with MkDocs and plugins
    - Remove Sphinx dependencies
    - Document Python version requirements

2. **GitHub Actions Workflow**:
    - Create `.github/workflows/docs.yml` for automated builds
    - Configure deployment to GitHub Pages
    - Set up build triggers (push to main, pull requests)

3. **Deployment Testing**:
    - Test manual deployment: `mkdocs gh-deploy`
    - Verify the GitHub Actions workflow
    - Confirm site accessibility on GitHub Pages URL
    - Test both languages on the deployed site

4. **Documentation Updates**:
    - Update `README.md` with new build instructions
    - Create a contributor guide for Markdown authoring
    - Document MkDocs workflow and commands
    - Update any references to Sphinx in project docs

5. **Cleanup**:
    - Remove Sphinx configuration files (`conf.py`, `Makefile`, etc.)
    - Remove Sphinx-specific directories (e.g., `_build/`, `_static/`, `_templates/`)
    - Archive Sphinx configuration for reference if needed

**Deliverables**:

- Updated `requirements.txt`
- Working GitHub Actions deployment pipeline
- Deployed site on GitHub Pages
- Updated contributor documentation
- Clean repository (Sphinx artifacts removed)

### Phase 6: Validation and Handoff (Day 7)

**Objective**: Final quality assurance and project handoff.

**Tasks**:

1. **Comprehensive Testing**:
    - Full site navigation check (all pages, all links)
    - Cross-browser testing (Chrome, Firefox, Safari)
    - Mobile device testing
    - Both language versions are validated
    - Search functionality in both locales

2. **Performance Check**:
    - Build time measurement
    - Page load speed verification
    - Check for broken links

3. **Documentation Review**:
    - Verify all contributor documentation is complete
    - Ensure build instructions are accurate
    - Confirm a deployment process is documented

4. **Handoff**:
    - Present the final site to Project Owner
    - Provide a migration summary report
    - Address any final adjustments needed
    - Merge migration branch to main upon approval

**Deliverables**:

- Fully functional MkDocs-based documentation site
- Migration summary report
- Complete contributor documentation
- Merged migration branch

### Success Criteria

Migration is considered successful when:

- [ ] All course content converted to Markdown and built without errors
- [ ] English and Ukrainian locales are both functional with working language switcher
- [ ] GitHub Pages deployment working automatically via GitHub Actions
- [ ] All images and assets display correctly
- [ ] Navigation and search work in both languages
- [ ] Site is responsive and works on mobile devices
- [ ] Contributor documentation updated with a Markdown authoring guide
- [ ] Sphinx artifacts removed from the repository
- [ ] Build time is acceptable (< 1 minute for a full build)
- [ ] Project Owner approves final site quality

### Risks and Mitigations

| Risk                                    | Impact | Mitigation                                                            |
|-----------------------------------------|--------|-----------------------------------------------------------------------|
| Pandoc conversion artifacts             | Medium | Manual review phase built into timeline; test conversions early       |
| i18n plugin limitations                 | Medium | Test plugin thoroughly in Phase 3; have fallback plan                 |
| Complex Sphinx features not convertible | Low    | Audit identified no advanced Sphinx features in current content       |
| Timeline overrun                        | Medium | Phased approach allows early detection; prioritize core functionality |
| Deployment pipeline issues              | Medium | Test deployment early; have manual deployment as fallback             |

### Rollback Plan

If critical issues emerge during migration:

1. Migration branch (`feature/mkdocs-migration`) keeps `main` branch intact
2. Sphinx environment remains in git history if reversion is needed
3. Can pause migration and maintain Sphinx in the short term if necessary
4. No changes to `main` branch until migration fully validated

## Related

- [ADR-003][ADR-003]: Repository File Structure (interdependent - structure decision affects migration effort)
- [ADR-004][ADR-004]: Presentation Framework Handling (may affect asset requirements and SSG choice)
- [ADR-001][ADR-001]: AI Guidelines Structure and Administration Framework

[//]: # (@formatter:off)
<!-- ADR references -->
[ADR-001]: ./ADR-001-ai-guidelines-structure.md
[ADR-002]: ./ADR-002-ssg-replacement.md
[ADR-003]: ./ADR-003-repo-file-structure.md
[ADR-004]: ./ADR-004-presentation-framework.md
[//]: # (formatter:on)
