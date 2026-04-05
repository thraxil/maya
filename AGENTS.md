# Agent Guidelines for Maya (Phoenix 1.8)

This file provides context and usage rules for AI coding assistants working on the Maya project.

## Core Phoenix & Elixir Idioms

*   **Module Naming:** Always use the `MayaWeb` namespace for web-related modules.
*   **LiveView Naming:** LiveView modules should always end with the `Live` suffix (e.g., `PageLive`).
*   **Router Aliases:** The default browser scope in the router is already aliased to `MayaWeb`. Do not prefix modules with `MayaWeb.` inside the router.

## LiveView Guidelines

*   **Flash Messages:** Use the `flash_group` component within layouts. Do not call it directly in individual LiveViews.
*   **Streams:** Always use `LiveView Streams` for collections (like lists of images) to optimize memory usage.
*   **JS Hooks:** When using a `Phoenix.Hook` that manages its own DOM, set the `phx-update="ignore"` attribute.

## Component & UI Standards

*   **Core Components:** Use the generated `CoreComponents` when available.
*   **Icons:** Use Heroicons via the `heroicons` library where possible.
*   **Forms:** Use the `to_form/2` helper when creating forms from maps or changesets.

## Testing Best Practices

*   **Phoenix Test:** Use `Phoenix.LiveViewTest` and `Phoenix.ConnTest` modules.
*   **Selectors:** Favor testing for the presence of key elements or data attributes rather than raw text content.
*   **Debug Statements:** If a test fails, use `render(view) |> IO.inspect()` to see the actual HTML being rendered.

## Project-Specific Commands

*   `mix phx.server`: Start the application.
*   `mix test`: Run the test suite.
*   `mix format`: Ensure code style compliance.
