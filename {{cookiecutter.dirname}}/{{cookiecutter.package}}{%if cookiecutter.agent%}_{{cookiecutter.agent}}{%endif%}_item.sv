{% include 'copyright' %}
  {%- set SEQ_ITEM = 'item' %}
{%- if cookiecutter.agent -%}
  {%- set SEQ_ITEM = cookiecutter.agent + '_item' %}
{%- endif %}

`ifndef __{{ cookiecutter.package | upper }}_{{ SEQ_ITEM | upper }}_SV__
 `define __{{ cookiecutter.package | upper }}_{{ SEQ_ITEM | upper }}_SV__

class {{ SEQ_ITEM }}_c extends uvm_sequence_item;

   cmn_pkg::uid_c uid;

   `uvm_object_utils_begin({{ cookiecutter.package }}_pkg::{{ SEQ_ITEM }}_c)
    `uvm_field_object(uid, UVM_REFERENCE)
   `uvm_object_utils_end
   
   function new(string name="{{ SEQ_ITEM }}", uvm_component parent);
      super.new(name, parent);
      uid = new("{{ cookiecutter.package | upper }}{% if cookiecutter.agent %}-{{ cookiecutter.agent | upper }}{% endif %}");
   endfunction : new

   virtual function string convert2string();
      `cmn_fatal(("FIXME convert2string not implemented"))
   endfunction : convert2string

endclass :  {{ SEQ_ITEM }}_c

`endif // guard
