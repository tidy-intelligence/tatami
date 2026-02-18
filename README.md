# tatami

> [!IMPORTANT]  
> The project is still in a Proof of Concept phase. If you have ideas or feature requests, please consider opening an issue 🙏

Quarto dashboards provide an accessible way to create interactive web applications using Python, R, Julia, and Observable. They simplify the development of Shiny apps by serving them through a single file, typically `index.qmd`. However, placing all server and UI logic in a single file can lead to messy, hard-to-maintain, and untestable code. Since Quarto dashboards support multiple files (see [official docs]((https://quarto.org/docs/interactive/shiny/execution.html#multiple-files))), there’s an opportunity to organize and modularize Quarto-based Shiny applications effectively.

`tatami` is an opinionated framework designed to bring structure and maintainability to Quarto dashboards. Inspired by modular tatami mats, this framework helps break down Shiny apps into reusable, testable components, making it easier to scale and collaborate.

There are already excellent frameworks for building production-ready, structured, and scalable Shiny applications:

- [`golem`](https://github.com/ThinkR-open/golem) encourages best practices by structuring the Shiny apps as an R package, with built-in functions for module creation and testing.
- [`rhino`](https://github.com/Appsilon/rhino) treats Shiny apps as a software engineering project rather than an R package, using `box` modules for modularization.
- [`leprechaun`](https://github.com/devOpifex/leprechaun) provides a lighweight alternative to `golem`, reducing boilerplate while maintaining structure.

`tatami` complements these frameworks by bringing a Quarto-native approach to modularization, allowing developers to: (i) organize Quarto dashboards into structured components; (ii) maintain sepration of UI, server logic, and modules; and (iii) improve testability and collaboration.

## Design

In traditional Shiny applications, the app is divided into two main components:

- UI: Defines the user interface, placing input elements and output placeholders.
- Server: Defines the logic, listening for input changes and modifying outputs reactively.

This clear separation helps structure Shiny apps and makes them highly flexible.

Quarto dashboards break this dichotomy: they automatically create dedicated boxes for each output object, so you are restricted in how to design the UI. Instead of manually defining the UI, you simply reference it in the Quarto document.

The idea of `tatami` modules is to facilitate laying out the outputs directly in the `.qmd` file - like tatami mats. 

## Roadmap

The framework is still highly experimental and work-in-progress. Here is the plan:

- [x] Create working example with modular architecture (multiple modules, tests, config, css, etc.)
- [x] Create helper functions for initialization a new app
- [ ] Prepare for CRAN release

## Installation

You can install the development version of `tatami` from GitHub:

```r
# install.packages("pak")
pak::pak("tidy-intelligence/tatami")
```

## Getting Started

### Create a new app

Use `create_app()` to scaffold a new Quarto dashboard project:

```r
library(tatami)
create_app("path/to/myapp")
```

This creates a project with the following structure:

```
myapp/
├── R/
│   ├── myapp-package.R
│   ├── run.R
│   ├── context_data.R
│   └── config.R
├── inst/
│   ├── config.yml
│   ├── _brand.yml
│   └── assets/
│       ├── css/
│       └── img/
├── tests/
│   ├── testthat.R
│   └── testthat/
├── man/
├── DESCRIPTION
├── NAMESPACE
└── index.qmd
```

### Add modules

Use `add_module()` to generate a new module with input, output, and server functions, along with a test file:

```r
add_module("chart", path = "path/to/myapp")
```

This creates:
- `R/mod_chart.R` with `chart_input()`, `chart_output()`, and `chart_server()` templates
- `tests/testthat/test-mod_chart.R` with corresponding tests

### Run the app

Start the dashboard with:

```r
run_app()
```

Use `run_app(production = TRUE)` to load the production configuration profile from `inst/config.yml`.

### Run the demo

To try the built-in example, clone this repo, install the required packages, and run:

```r
quarto::quarto_serve("index.qmd")
```

