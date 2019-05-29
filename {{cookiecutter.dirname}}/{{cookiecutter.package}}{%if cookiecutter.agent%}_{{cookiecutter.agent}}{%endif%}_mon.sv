{% include 'copyright' %}
  {%- set MON = 'mon' -%}
  {%- set INTF = cookiecutter.package + '_intf' %}
  {%- set SEQ_ITEM = 'item' %}
{%- if cookiecutter.agent -%}
  {%- set MON = cookiecutter.agent + '_mon' -%}
  {%- set INTF = cookiecutter.package + '_' + cookiecutter.agent + '_intf' %}
  {%- set SEQ_ITEM = cookiecutter.agent + '_item' %}
{%- endif %}

`ifndef __{{ cookiecutter.package | upper }}_{{ MON | upper }}_SV__
 `define __{{ cookiecutter.package | upper }}_{{ MON | upper }}_SV__

 `include "{{ cookiecutter.package }}_{{ SEQ_ITEM }}.sv"

class {{ MON }}_c extends uvm_monitor #({{ SEQ_ITEM }}_c);

   // Containing agent sets variable to avoid multiple lookup
   virtual {{ INTF }} vif;

   uvm_analys_port #({{ SEQ_ITEM }}_c) mon_item_port;

   `uvm_component_utils_begin({{ cookiecutter.package }}_pkg::{{ MON }}_c)
   `uvm_component_utils_end

   function new(string name="{{ MON }}", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual task build_phase(uvm_phase phase);
      super.build_phase(phase);
      this.mon_item_port = new("mon_item_port", this);
   endtask : build_phase

   virtual task run_phase(uvm_phase phase);
      forever begin
         @(posedge this.vif.mon_cb.rst_n);
         fork
            monitor_thread();
         join_none
         @(negedge this.vif.mon_cb.rst_n);
         disable fork;
      end
   endtask : run_phase

   virtual task monitor_thread();
      {{ SEQ_ITEM }}_c item;
      `cmn_fatal(("FIXME monitor not implemented"))
      forever begin
         @(this.vif_mon_cb);
         item = {{ SEQ_ITEM }}_c::type_id::create("item");
         `cmn_dbg(300, ("MON: %s", item.convert2string()))
         this.mon_item_port.write(item);
      end
   endtask : monitor_thread

endclass :  {{ MON }}_c

`endif // guard
