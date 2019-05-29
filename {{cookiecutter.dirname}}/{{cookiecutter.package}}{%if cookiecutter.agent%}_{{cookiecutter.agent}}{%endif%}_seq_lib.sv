{% include 'copyright' %}
  {%- set SQR = 'sqr' -%}
  {%- set SEQ_ITEM = 'item' %}
  {%- set BASE_SEQ = 'seq' %}
{%- if cookiecutter.agent -%}
  {%- set SQR = cookiecutter.agent + '_sqr' -%}
  {%- set SEQ_ITEM = cookiecutter.agent + '_item' %}
  {%- set BASE_SEQ = cookiecutter.agent + '_seq' %}
{%- endif %}

`ifndef __{{ cookiecutter.package | upper }}{% if cookiecutter.agent %}_{{ cookiecutter.agent | upper }}{% endif %}_SEQ_LIB_SV__
 `define __{{ cookiecutter.package | upper }}{% if cookiecutter.agent %}_{{ cookiecutter.agent | upper }}{% endif %}_SEQ_LIB_SV__

typedef class {{ SQR }}_c;

class {{ BASE_SEQ }}_c extends  uvm_sequence #({{ SEQ_ITEM }}_c);

   `uvm_object_utils_begin({{ cookiecutter.package }}_pkg::{{ BASE_SEQ }}_c)
   `uvm_object_utils_end

   // `uvm_declare_p_sequencer({{ SQR }}_c)

   function new(string name="{{ BASE_SEQ }}");
      super.new(name);
   endfunction : new

   virtual task body();
      `cmn_fatal(("FIXME body not implemented"))
   endtask : body

endclass :  {{ BASE_SEQ }}_c

`endif // guard
