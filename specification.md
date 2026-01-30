# typeahead R pkg specifications

## expected behavior

- users can create typeahead text inputs using the `typeaheadInput()` function
- the `typeaheadInput()` function exposes core functionality of the `typeahead-standalone` JavaScript library with dropdown suggestions
- users can dynamically update typeahead choices and selected values using `updateTypeaheadInput()`, following `updateSelectInput()` behavior:
    - multiple rapid calls are batched and only the final state is sent to browser after the reactive cycle completes
- default styling matches `selectInput` appearance and behavior
- supports `bslib` theming and customization
- Shiny reactivity triggers only on selection, not on every keystroke
- the api should match `selectInput` as far as is reasonable to offer a familiar interface
- empty state handling: with `choices = character(0)` or `NULL`, renders functional input field with no suggestions and `NULL` value and return value `""`

## possible extension

- [ ] add `hint` parameter for auto-completion hints (requires fixing Bootstrap CSS positioning issues!)
- [ ] make it possible for the typeahead input to load remote data
- [ ] add `reactive_on` parameter to control when shiny reactivity triggers (e.g., "selection", "input", "debounced")
- [ ] add `template` parameter for complex entry templates with rich display formatting
- [ ] enable `server`-side processing
- [ ] enable named choices to allow for differences between display/backend value
