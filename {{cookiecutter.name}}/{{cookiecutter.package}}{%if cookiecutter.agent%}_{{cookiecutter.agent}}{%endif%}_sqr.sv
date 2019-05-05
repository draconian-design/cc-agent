{% include 'copyright' %}
  {%- set SQR = 'sqr' -%}
  {%- set INTF = cookiecutter.package + '_intf' %}
  {%- set SEQ_ITEM = 'item' %}
{%- if cookiecutter.agent -%}
  {%- set SQR = cookiecutter.agent + '_sqr' -%}
  {%- set INTF = cookiecutter.package + '_' + cookiecutter.agent + '_intf' %}
  {%- set SEQ_ITEM = cookiecutter.agent + '_item' %}                
{%- endif %}

`ifndef __{{ cookiecutter.package | upper }}_{{ SQR | upper }}_SV__
 `define __{{ cookiecutter.package | upper }}_{{ SQR | upper }}_SV__

 `include "{{ cookiecutter.package }}_{{ SEQ_ITEM }}.sv"
                      
class {{ SQR }}_c extends uvm_sequencer #({{ SEQ_ITEM }}_c, {{ SEQ_ITEM }}_c);

   // Containing agent sets variable to avoid multiple lookup
   virtual {{ INTF }} vif;

   `uvm_component_utils_begin({{ cookiecutter.package }}_pkg::{{ SQR }}_c)
   `uvm_component_utils_end({{ cookiecutter.package }}_pkg::{{ SQR }}_c)
   
   function new(string name="{{ SQR }}", uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass :  {{ SQR }}_c

`endif // guard
