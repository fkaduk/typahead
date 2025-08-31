# typeaheadInput snapshot tests: renders basic UI correctly

    Code
      ui
    Output
      <label for="fruits">Select a fruit:</label>
      <input id="fruits" type="text" class="typeahead-standalone form-control" autocomplete="off" value="Apple" data-source="[&quot;Apple&quot;,&quot;Banana&quot;,&quot;Cherry&quot;]" data-options="{&quot;limit&quot;:8,&quot;minLength&quot;:1,&quot;hint&quot;:false}" placeholder="Start typing..."/>

# typeaheadInput snapshot tests: renders minimal UI correctly

    Code
      ui
    Output
      <input id="minimal" type="text" class="typeahead-standalone form-control" autocomplete="off" value="" data-source="[]" data-options="{&quot;limit&quot;:8,&quot;minLength&quot;:1,&quot;hint&quot;:false}"/>

