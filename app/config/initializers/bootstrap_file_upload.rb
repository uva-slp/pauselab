module SimpleForm
  module Inputs
    class FileInput < Base
      def input(wrapper_options)
        idf = "#{lookup_model_names.join("_")}_#{reflection_or_attribute_name}"
        input_html_options[:style] ||= 'display:none;'

        button = template.content_tag(:div, class: 'custom-file') do
          template.tag(:input, id: "pbox_#{idf}", class: 'custom-file-input', type: 'text') +
          template.content_tag(:span, "Browse", class: 'custom-file-control pull-right', onclick: "$('input[id=#{idf}]').click();")
        end

        script = template.content_tag(:script, type: 'text/javascript') do
          "$('input[id=#{idf}]').change(function() { s = $(this).val(); $('#pbox_#{idf}').val(s.slice(s.lastIndexOf('\\\\\\\\')+1)); console.log(s);});".html_safe
        end

        @builder.file_field(attribute_name, input_html_options) + button + script
      end
    end
  end
end
