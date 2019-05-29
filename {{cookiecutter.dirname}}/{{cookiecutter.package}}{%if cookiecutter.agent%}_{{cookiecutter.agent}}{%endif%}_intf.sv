{% include 'copyright' %}
  {%- set INTF = cookiecutter.package + '_intf' %}
{%- if cookiecutter.agent -%}
  {%- set INTF = cookiecutter.package + '_' + cookiecutter.agent + '_intf' %}
{%- endif %}

`ifndef __{{ INTF | upper }}_SV__
 `define __{{ INTF | upper }}_SV__

interface {{ INTF }}(input logic clk, input logic rst_n);
   import uvm_pkg::*;

   clocking drv_cb @(posedge clk);
   endclocking : drv_cb

   clocking mon_cb @(posedge clk);
   endclocking : mon_cb

endinterface : {{ INTF }}

`endif // guard
