{% include 'copyright' %}
  {%- set NAME = 'agent' -%}
  {%- set MON  = 'mon'   -%}
  {%- set DRV  = 'drv'   -%}
  {%- set SQR  = 'sqr'   -%}
  {%- set INTF = cookiecutter.package + '_intf' %}
{%- if cookiecutter.agent -%}
  {%- set NAME = cookiecutter.agent + '_agent' -%}
  {%- set MON  = cookiecutter.agent + '_mon'   -%}
  {%- set DRV  = cookiecutter.agent + '_drv'   -%}
  {%- set SQR  = cookiecutter.agent + '_sqr'   -%}
  {%- set INTF = cookiecutter.package + '_' + cookiecutter.agent + '_intf' %}                 
{%- endif %}

`ifndef __{{ cookiecutter.package | upper }}_{{ NAME | upper }}_SV__
 `define __{{ cookiecutter.package | upper }}_{{ NAME | upper }}_SV__

 `include "{{ cookiecutter.package }}_{{ MON }}.sv"
 `include "{{ cookiecutter.package }}_{{ DRV }}.sv"
 `include "{{ cookiecutter.package }}_{{ SQR }}.sv"                      
                      
class {{ NAME }}_c extends uvm_component;

   string intf_name;
   virtual {{ INTF }} vif;

   {{ MON }}_c mon;
   {{ DRV }}_c drv;
   {{ SQR }}_c sqr;
   
   `uvm_component_utils_begin({{ cookiecutter.package }}_pkg::{{ NAME }}_c)
    `uvm_field_string(intf_name, UVM_ALL_ON)
   `uvm_component_utils_end({{ cookiecutter.package }}_pkg::{{ NAME }}_c)
   
   function new(string name="{{ NAME }}", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual task build_phase(uvm_phase phase);
      super.build_phase(phase);
      `cmn_get_intf(virtual {{ INTF }}, "{{ cookiecutter.package }}_pkg::{{ INTF }}", this.intf_name, this.vif)
      this.mon = {{ MON }}_c::type_id::create("mon", this);
      this.mon.vif = this.vif; // Avoid additional db lookups
      if (this.get_is_active() == UVM_ACTIVE) begin
         this.drv = {{ DRV }}_c::type_id::create("drv", this);
         this.drv.vif = this.vif; // Avoid additional db lookups
         this.sqr = {{ SQR }}_c::type_id::create("sqr", this);
         this.sqr.vif = this.vif; // Avoid additional db lookups
      end
   endtask : build_phase

   virtual task connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if (this.get_is_active() == UVM_ACTIVE) begin
         this.drv.seq_item_port.connect(this.sqr.seq_item_export);
      end
   endtask : connect_phase

endclass :  {{ NAME }}_c

`endif // guard  
