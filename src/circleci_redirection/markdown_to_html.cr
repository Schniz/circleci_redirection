module CircleciRedirection
  module MarkdownToHtml
    macro grip(path)
      {% if system("which grip || true") != "" %}
        {{system("grip #{path} --export -").stringify}}
      {% else %}
        {% warning = "Warning: Grip is not installed. `brew install grip` can fix that." %}
        {% puts(warning) %}
        {{warning}}
      {% end %}
    end
  end
end
