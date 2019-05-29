{% include 'copyright' %}
  {%- set DRV = 'drv' -%}
  {%- set INTF = cookiecutter.package + '_intf' %}
  {%- set SEQ_ITEM = 'item' %}
{%- if cookiecutter.agent -%}
  {%- set DRV = cookiecutter.agent + '_drv' -%}
  {%- set INTF = cookiecutter.package + '_' + cookiecutter.agent + '_intf' %}
  {%- set SEQ_ITEM = cookiecutter.agent + '_item' %}
{%- endif %}

`ifndef __{{ cookiecutter.package | upper }}_{{ DRV | upper }}_SV__
 `define __{{ cookiecutter.package | upper }}_{{ DRV | upper }}_SV__

 `include "{{ cookiecutter.package }}_{{ SEQ_ITEM }}.sv"

class {{ DRV }}_c extends uvm_driver #({{ SEQ_ITEM }}_c);

   // Containing agent sets variable to avoid multiple lookup
   virtual {{ INTF }} vif;

   `uvm_component_utils_begin({{ cookiecutter.package }}_pkg::{{ DRV }}_c)
   `uvm_component_utils_end

   function new(string name="{{ DRV }}", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual task run_phase(uvm_phase phase);
      forever begin
         @(posedge this.vif.mon_cb.rst_n);
         fork
            drvitor_thread();
         join_none
         @(negedge this.vif.mon_cb.rst_n);
         disable fork;
      end
   endtask : run_phase

   virtual task driver_thread();
      forever begin
         this.seq_item_port.get_next_item(this.req);
         drive_request(this.req);;
         this.seq_item_port.item_done();
      end
   endtask : driver_thread

   virtual task drive_request({{ SEQ_ITEM }} _item);
      `cmn_fatal(("FIXME driver not implemented"))
   endtask : drive_request

endclass :  {{ DRV }}_c

`endif // guard
