# File saved with Nlview 7.7.1 2023-07-26 3bc4126617 VDI=43 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 15
property maxzoom 6.25
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 15
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new top work:top:NOFILE -nosplit
load symbol bus_arbiter work:bus_arbiter:NOFILE HIERBOX pin clk input.left pin rst input.left pinBus bus_grant output.right [1:0] pinBus bus_phase input.left [1:0] pinBus bus_req input.left [1:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol bus_interface work:bus_interface:NOFILE HIERBOX pin active_core output.right pin any_shared output.right pin clk input.left pin ctrl_bus_shared_0 input.left pin ctrl_bus_shared_1 input.left pin ctrl_data_valid_0 input.left pin ctrl_data_valid_1 input.left pin mem_data_valid input.left pin mem_req output.right pin rst input.left pin snoop_data_ready output.right pin snoop_valid output.right pinBus bus_grant input.left [1:0] pinBus bus_phase output.right [1:0] pinBus ctrl_bus_addr_0 input.left [7:0] pinBus ctrl_bus_addr_1 input.left [7:0] pinBus ctrl_bus_cmd_0 input.left [2:0] pinBus ctrl_bus_cmd_1 input.left [2:0] pinBus ctrl_bus_req input.left [1:0] pinBus ctrl_bus_wdata_0 input.left [63:0] pinBus ctrl_bus_wdata_1 input.left [63:0] pinBus mem_addr output.right [7:0] pinBus mem_cmd output.right [2:0] pinBus mem_data input.left [63:0] pinBus mem_wdata output.right [63:0] pinBus snoop_addr output.right [7:0] pinBus snoop_cmd output.right [2:0] pinBus snoop_data output.right [63:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol cache_array work:cache_array:NOFILE HIERBOX pin clk input.left pin evict_way input.left pin hit output.right pin hit_way output.right pin lru_way_out output.right pin rst input.left pin write_en input.left pin write_way input.left pinBus evict_addr_out output.right [7:0] pinBus evict_data output.right [63:0] pinBus evict_mesi output.right [1:0] pinBus evict_set input.left [1:0] pinBus hit_data output.right [63:0] pinBus hit_mesi output.right [1:0] pinBus lookup_addr input.left [7:0] pinBus write_addr input.left [7:0] pinBus write_data input.left [63:0] pinBus write_mesi input.left [1:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol cache_array work:abstract:NOFILE HIERBOX pin clk input.left pin evict_way input.left pin hit output.right pin hit_way output.right pin lru_way_out output.right pin rst input.left pin write_en input.left pin write_way input.left pinBus evict_addr_out output.right [7:0] pinBus evict_data output.right [63:0] pinBus evict_mesi output.right [1:0] pinBus evict_set input.left [1:0] pinBus hit_data output.right [63:0] pinBus hit_mesi output.right [1:0] pinBus lookup_addr input.left [7:0] pinBus write_addr input.left [7:0] pinBus write_data input.left [63:0] pinBus write_mesi input.left [1:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol mesi_controller work:mesi_controller:NOFILE HIERBOX pin any_shared input.left pin bus_data_valid output.right pin bus_grant input.left pin bus_req output.right pin bus_shared output.right pin ca_evict_way output.right pin ca_hit input.left pin ca_hit_way input.left pin ca_lru_way input.left pin ca_write_en output.right pin ca_write_way output.right pin clk input.left pin pr_ack output.right pin pr_req input.left pin pr_we input.left pin rst input.left pin snoop_data_ready input.left pin snoop_valid input.left pinBus bus_addr output.right [7:0] pinBus bus_cmd output.right [2:0] pinBus bus_wdata output.right [63:0] pinBus ca_evict_addr input.left [7:0] pinBus ca_evict_data input.left [63:0] pinBus ca_evict_mesi input.left [1:0] pinBus ca_evict_set output.right [1:0] pinBus ca_hit_data input.left [63:0] pinBus ca_hit_mesi input.left [1:0] pinBus ca_lookup_addr output.right [7:0] pinBus ca_write_addr output.right [7:0] pinBus ca_write_data output.right [63:0] pinBus ca_write_mesi output.right [1:0] pinBus pr_addr input.left [7:0] pinBus pr_rdata output.right [7:0] pinBus pr_wdata input.left [7:0] pinBus snoop_addr input.left [7:0] pinBus snoop_cmd input.left [2:0] pinBus snoop_data input.left [63:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol mesi_controller work:abstract:NOFILE HIERBOX pin any_shared input.left pin bus_data_valid output.right pin bus_grant input.left pin bus_req output.right pin bus_shared output.right pin ca_evict_way output.right pin ca_hit input.left pin ca_hit_way input.left pin ca_lru_way input.left pin ca_write_en output.right pin ca_write_way output.right pin clk input.left pin pr_ack output.right pin pr_req input.left pin pr_we input.left pin rst input.left pin snoop_data_ready input.left pin snoop_valid input.left pinBus bus_addr output.right [7:0] pinBus bus_cmd output.right [2:0] pinBus bus_wdata output.right [63:0] pinBus ca_evict_addr input.left [7:0] pinBus ca_evict_data input.left [63:0] pinBus ca_evict_mesi input.left [1:0] pinBus ca_evict_set output.right [1:0] pinBus ca_hit_data input.left [63:0] pinBus ca_hit_mesi input.left [1:0] pinBus ca_lookup_addr output.right [7:0] pinBus ca_write_addr output.right [7:0] pinBus ca_write_data output.right [63:0] pinBus ca_write_mesi output.right [1:0] pinBus pr_addr input.left [7:0] pinBus pr_rdata output.right [7:0] pinBus pr_wdata input.left [7:0] pinBus snoop_addr input.left [7:0] pinBus snoop_cmd input.left [2:0] pinBus snoop_data input.left [63:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol memory_controller work:memory_controller:NOFILE HIERBOX pin clk input.left pin mem_data_valid output.right pin mem_req input.left pin mem_wb_ack output.right pin rst input.left pinBus mem_addr input.left [7:0] pinBus mem_cmd input.left [2:0] pinBus mem_data output.right [63:0] pinBus mem_wdata input.left [63:0] boxcolor 1 fillcolor 2 minwidth 13%
load port clk input -pg 1 -lvl 0 -x 0 -y 540
load port dbg_any_shared output -pg 1 -lvl 5 -x 2470 -y 940
load port pr0_ack output -pg 1 -lvl 5 -x 2470 -y 520
load port pr0_req input -pg 1 -lvl 0 -x 0 -y 450
load port pr0_we input -pg 1 -lvl 0 -x 0 -y 510
load port pr1_ack output -pg 1 -lvl 5 -x 2470 -y 1330
load port pr1_req input -pg 1 -lvl 0 -x 0 -y 1000
load port pr1_we input -pg 1 -lvl 0 -x 0 -y 1060
load port rst input -pg 1 -lvl 0 -x 0 -y 570
load portBus dbg_bus_grant output [1:0] -attr @name dbg_bus_grant[1:0] -pg 1 -lvl 5 -x 2470 -y 1250
load portBus dbg_bus_phase output [1:0] -attr @name dbg_bus_phase[1:0] -pg 1 -lvl 5 -x 2470 -y 970
load portBus dbg_snoop_addr output [7:0] -attr @name dbg_snoop_addr[7:0] -pg 1 -lvl 5 -x 2470 -y 1070
load portBus dbg_snoop_cmd output [2:0] -attr @name dbg_snoop_cmd[2:0] -pg 1 -lvl 5 -x 2470 -y 1100
load portBus pr0_addr input [7:0] -attr @name pr0_addr[7:0] -pg 1 -lvl 0 -x 0 -y 420
load portBus pr0_rdata output [7:0] -attr @name pr0_rdata[7:0] -pg 1 -lvl 5 -x 2470 -y 550
load portBus pr0_wdata input [7:0] -attr @name pr0_wdata[7:0] -pg 1 -lvl 0 -x 0 -y 480
load portBus pr1_addr input [7:0] -attr @name pr1_addr[7:0] -pg 1 -lvl 0 -x 0 -y 970
load portBus pr1_rdata output [7:0] -attr @name pr1_rdata[7:0] -pg 1 -lvl 5 -x 2470 -y 1370
load portBus pr1_wdata input [7:0] -attr @name pr1_wdata[7:0] -pg 1 -lvl 0 -x 0 -y 1030
load inst u_arbiter bus_arbiter work:bus_arbiter:NOFILE -autohide -attr @cell(#000000) bus_arbiter -pinBusAttr bus_grant @name bus_grant[1:0] -pinBusAttr bus_phase @name bus_phase[1:0] -pinBusAttr bus_req @name bus_req[1:0] -pg 1 -lvl 3 -x 1480 -y 980
load inst u_bus bus_interface work:bus_interface:NOFILE -autohide -attr @cell(#000000) bus_interface -pinAttr active_core @attr n/c -pinBusAttr bus_grant @name bus_grant[1:0] -pinBusAttr bus_phase @name bus_phase[1:0] -pinBusAttr ctrl_bus_addr_0 @name ctrl_bus_addr_0[7:0] -pinBusAttr ctrl_bus_addr_1 @name ctrl_bus_addr_1[7:0] -pinBusAttr ctrl_bus_cmd_0 @name ctrl_bus_cmd_0[2:0] -pinBusAttr ctrl_bus_cmd_1 @name ctrl_bus_cmd_1[2:0] -pinBusAttr ctrl_bus_req @name ctrl_bus_req[1:0] -pinBusAttr ctrl_bus_wdata_0 @name ctrl_bus_wdata_0[63:0] -pinBusAttr ctrl_bus_wdata_1 @name ctrl_bus_wdata_1[63:0] -pinBusAttr mem_addr @name mem_addr[7:0] -pinBusAttr mem_cmd @name mem_cmd[2:0] -pinBusAttr mem_data @name mem_data[63:0] -pinBusAttr mem_wdata @name mem_wdata[63:0] -pinBusAttr snoop_addr @name snoop_addr[7:0] -pinBusAttr snoop_cmd @name snoop_cmd[2:0] -pinBusAttr snoop_data @name snoop_data[63:0] -pg 1 -lvl 4 -x 2060 -y 900
load inst u_cache0 cache_array work:cache_array:NOFILE -autohide -attr @cell(#000000) cache_array -pinBusAttr evict_addr_out @name evict_addr_out[7:0] -pinBusAttr evict_data @name evict_data[63:0] -pinBusAttr evict_mesi @name evict_mesi[1:0] -pinBusAttr evict_set @name evict_set[1:0] -pinBusAttr hit_data @name hit_data[63:0] -pinBusAttr hit_mesi @name hit_mesi[1:0] -pinBusAttr lookup_addr @name lookup_addr[7:0] -pinBusAttr write_addr @name write_addr[7:0] -pinBusAttr write_data @name write_data[63:0] -pinBusAttr write_mesi @name write_mesi[1:0] -pg 1 -lvl 1 -x 310 -y 180
load inst u_cache1 cache_array work:abstract:NOFILE -autohide -attr @cell(#000000) cache_array -pinBusAttr evict_addr_out @name evict_addr_out[7:0] -pinBusAttr evict_data @name evict_data[63:0] -pinBusAttr evict_mesi @name evict_mesi[1:0] -pinBusAttr evict_set @name evict_set[1:0] -pinBusAttr hit_data @name hit_data[63:0] -pinBusAttr hit_mesi @name hit_mesi[1:0] -pinBusAttr lookup_addr @name lookup_addr[7:0] -pinBusAttr write_addr @name write_addr[7:0] -pinBusAttr write_data @name write_data[63:0] -pinBusAttr write_mesi @name write_mesi[1:0] -pg 1 -lvl 1 -x 310 -y 760
load inst u_ctrl0 mesi_controller work:mesi_controller:NOFILE -autohide -attr @cell(#000000) mesi_controller -pinBusAttr bus_addr @name bus_addr[7:0] -pinBusAttr bus_cmd @name bus_cmd[2:0] -pinBusAttr bus_wdata @name bus_wdata[63:0] -pinBusAttr ca_evict_addr @name ca_evict_addr[7:0] -pinBusAttr ca_evict_data @name ca_evict_data[63:0] -pinBusAttr ca_evict_mesi @name ca_evict_mesi[1:0] -pinBusAttr ca_evict_set @name ca_evict_set[1:0] -pinBusAttr ca_hit_data @name ca_hit_data[63:0] -pinBusAttr ca_hit_mesi @name ca_hit_mesi[1:0] -pinBusAttr ca_lookup_addr @name ca_lookup_addr[7:0] -pinBusAttr ca_write_addr @name ca_write_addr[7:0] -pinBusAttr ca_write_data @name ca_write_data[63:0] -pinBusAttr ca_write_mesi @name ca_write_mesi[1:0] -pinBusAttr pr_addr @name pr_addr[7:0] -pinBusAttr pr_rdata @name pr_rdata[7:0] -pinBusAttr pr_wdata @name pr_wdata[7:0] -pinBusAttr snoop_addr @name snoop_addr[7:0] -pinBusAttr snoop_cmd @name snoop_cmd[2:0] -pinBusAttr snoop_data @name snoop_data[63:0] -pg 1 -lvl 2 -x 910 -y 200
load inst u_ctrl1 mesi_controller work:abstract:NOFILE -autohide -attr @cell(#000000) mesi_controller -pinBusAttr bus_addr @name bus_addr[7:0] -pinBusAttr bus_cmd @name bus_cmd[2:0] -pinBusAttr bus_wdata @name bus_wdata[63:0] -pinBusAttr ca_evict_addr @name ca_evict_addr[7:0] -pinBusAttr ca_evict_data @name ca_evict_data[63:0] -pinBusAttr ca_evict_mesi @name ca_evict_mesi[1:0] -pinBusAttr ca_evict_set @name ca_evict_set[1:0] -pinBusAttr ca_hit_data @name ca_hit_data[63:0] -pinBusAttr ca_hit_mesi @name ca_hit_mesi[1:0] -pinBusAttr ca_lookup_addr @name ca_lookup_addr[7:0] -pinBusAttr ca_write_addr @name ca_write_addr[7:0] -pinBusAttr ca_write_data @name ca_write_data[63:0] -pinBusAttr ca_write_mesi @name ca_write_mesi[1:0] -pinBusAttr pr_addr @name pr_addr[7:0] -pinBusAttr pr_rdata @name pr_rdata[7:0] -pinBusAttr pr_wdata @name pr_wdata[7:0] -pinBusAttr snoop_addr @name snoop_addr[7:0] -pinBusAttr snoop_cmd @name snoop_cmd[2:0] -pinBusAttr snoop_data @name snoop_data[63:0] -pg 1 -lvl 2 -x 910 -y 740
load inst u_memory memory_controller work:memory_controller:NOFILE -autohide -attr @cell(#000000) memory_controller -pinAttr mem_wb_ack @attr n/c -pinBusAttr mem_addr @name mem_addr[7:0] -pinBusAttr mem_cmd @name mem_cmd[2:0] -pinBusAttr mem_data @name mem_data[63:0] -pinBusAttr mem_wdata @name mem_wdata[63:0] -pg 1 -lvl 3 -x 1480 -y 1560
load net ca0_ev_addr[0] -attr @rip evict_addr_out[0] -pin u_cache0 evict_addr_out[0] -pin u_ctrl0 ca_evict_addr[0]
load net ca0_ev_addr[1] -attr @rip evict_addr_out[1] -pin u_cache0 evict_addr_out[1] -pin u_ctrl0 ca_evict_addr[1]
load net ca0_ev_addr[2] -attr @rip evict_addr_out[2] -pin u_cache0 evict_addr_out[2] -pin u_ctrl0 ca_evict_addr[2]
load net ca0_ev_addr[3] -attr @rip evict_addr_out[3] -pin u_cache0 evict_addr_out[3] -pin u_ctrl0 ca_evict_addr[3]
load net ca0_ev_addr[4] -attr @rip evict_addr_out[4] -pin u_cache0 evict_addr_out[4] -pin u_ctrl0 ca_evict_addr[4]
load net ca0_ev_addr[5] -attr @rip evict_addr_out[5] -pin u_cache0 evict_addr_out[5] -pin u_ctrl0 ca_evict_addr[5]
load net ca0_ev_addr[6] -attr @rip evict_addr_out[6] -pin u_cache0 evict_addr_out[6] -pin u_ctrl0 ca_evict_addr[6]
load net ca0_ev_addr[7] -attr @rip evict_addr_out[7] -pin u_cache0 evict_addr_out[7] -pin u_ctrl0 ca_evict_addr[7]
load net ca0_ev_data[0] -attr @rip evict_data[0] -pin u_cache0 evict_data[0] -pin u_ctrl0 ca_evict_data[0]
load net ca0_ev_data[10] -attr @rip evict_data[10] -pin u_cache0 evict_data[10] -pin u_ctrl0 ca_evict_data[10]
load net ca0_ev_data[11] -attr @rip evict_data[11] -pin u_cache0 evict_data[11] -pin u_ctrl0 ca_evict_data[11]
load net ca0_ev_data[12] -attr @rip evict_data[12] -pin u_cache0 evict_data[12] -pin u_ctrl0 ca_evict_data[12]
load net ca0_ev_data[13] -attr @rip evict_data[13] -pin u_cache0 evict_data[13] -pin u_ctrl0 ca_evict_data[13]
load net ca0_ev_data[14] -attr @rip evict_data[14] -pin u_cache0 evict_data[14] -pin u_ctrl0 ca_evict_data[14]
load net ca0_ev_data[15] -attr @rip evict_data[15] -pin u_cache0 evict_data[15] -pin u_ctrl0 ca_evict_data[15]
load net ca0_ev_data[16] -attr @rip evict_data[16] -pin u_cache0 evict_data[16] -pin u_ctrl0 ca_evict_data[16]
load net ca0_ev_data[17] -attr @rip evict_data[17] -pin u_cache0 evict_data[17] -pin u_ctrl0 ca_evict_data[17]
load net ca0_ev_data[18] -attr @rip evict_data[18] -pin u_cache0 evict_data[18] -pin u_ctrl0 ca_evict_data[18]
load net ca0_ev_data[19] -attr @rip evict_data[19] -pin u_cache0 evict_data[19] -pin u_ctrl0 ca_evict_data[19]
load net ca0_ev_data[1] -attr @rip evict_data[1] -pin u_cache0 evict_data[1] -pin u_ctrl0 ca_evict_data[1]
load net ca0_ev_data[20] -attr @rip evict_data[20] -pin u_cache0 evict_data[20] -pin u_ctrl0 ca_evict_data[20]
load net ca0_ev_data[21] -attr @rip evict_data[21] -pin u_cache0 evict_data[21] -pin u_ctrl0 ca_evict_data[21]
load net ca0_ev_data[22] -attr @rip evict_data[22] -pin u_cache0 evict_data[22] -pin u_ctrl0 ca_evict_data[22]
load net ca0_ev_data[23] -attr @rip evict_data[23] -pin u_cache0 evict_data[23] -pin u_ctrl0 ca_evict_data[23]
load net ca0_ev_data[24] -attr @rip evict_data[24] -pin u_cache0 evict_data[24] -pin u_ctrl0 ca_evict_data[24]
load net ca0_ev_data[25] -attr @rip evict_data[25] -pin u_cache0 evict_data[25] -pin u_ctrl0 ca_evict_data[25]
load net ca0_ev_data[26] -attr @rip evict_data[26] -pin u_cache0 evict_data[26] -pin u_ctrl0 ca_evict_data[26]
load net ca0_ev_data[27] -attr @rip evict_data[27] -pin u_cache0 evict_data[27] -pin u_ctrl0 ca_evict_data[27]
load net ca0_ev_data[28] -attr @rip evict_data[28] -pin u_cache0 evict_data[28] -pin u_ctrl0 ca_evict_data[28]
load net ca0_ev_data[29] -attr @rip evict_data[29] -pin u_cache0 evict_data[29] -pin u_ctrl0 ca_evict_data[29]
load net ca0_ev_data[2] -attr @rip evict_data[2] -pin u_cache0 evict_data[2] -pin u_ctrl0 ca_evict_data[2]
load net ca0_ev_data[30] -attr @rip evict_data[30] -pin u_cache0 evict_data[30] -pin u_ctrl0 ca_evict_data[30]
load net ca0_ev_data[31] -attr @rip evict_data[31] -pin u_cache0 evict_data[31] -pin u_ctrl0 ca_evict_data[31]
load net ca0_ev_data[32] -attr @rip evict_data[32] -pin u_cache0 evict_data[32] -pin u_ctrl0 ca_evict_data[32]
load net ca0_ev_data[33] -attr @rip evict_data[33] -pin u_cache0 evict_data[33] -pin u_ctrl0 ca_evict_data[33]
load net ca0_ev_data[34] -attr @rip evict_data[34] -pin u_cache0 evict_data[34] -pin u_ctrl0 ca_evict_data[34]
load net ca0_ev_data[35] -attr @rip evict_data[35] -pin u_cache0 evict_data[35] -pin u_ctrl0 ca_evict_data[35]
load net ca0_ev_data[36] -attr @rip evict_data[36] -pin u_cache0 evict_data[36] -pin u_ctrl0 ca_evict_data[36]
load net ca0_ev_data[37] -attr @rip evict_data[37] -pin u_cache0 evict_data[37] -pin u_ctrl0 ca_evict_data[37]
load net ca0_ev_data[38] -attr @rip evict_data[38] -pin u_cache0 evict_data[38] -pin u_ctrl0 ca_evict_data[38]
load net ca0_ev_data[39] -attr @rip evict_data[39] -pin u_cache0 evict_data[39] -pin u_ctrl0 ca_evict_data[39]
load net ca0_ev_data[3] -attr @rip evict_data[3] -pin u_cache0 evict_data[3] -pin u_ctrl0 ca_evict_data[3]
load net ca0_ev_data[40] -attr @rip evict_data[40] -pin u_cache0 evict_data[40] -pin u_ctrl0 ca_evict_data[40]
load net ca0_ev_data[41] -attr @rip evict_data[41] -pin u_cache0 evict_data[41] -pin u_ctrl0 ca_evict_data[41]
load net ca0_ev_data[42] -attr @rip evict_data[42] -pin u_cache0 evict_data[42] -pin u_ctrl0 ca_evict_data[42]
load net ca0_ev_data[43] -attr @rip evict_data[43] -pin u_cache0 evict_data[43] -pin u_ctrl0 ca_evict_data[43]
load net ca0_ev_data[44] -attr @rip evict_data[44] -pin u_cache0 evict_data[44] -pin u_ctrl0 ca_evict_data[44]
load net ca0_ev_data[45] -attr @rip evict_data[45] -pin u_cache0 evict_data[45] -pin u_ctrl0 ca_evict_data[45]
load net ca0_ev_data[46] -attr @rip evict_data[46] -pin u_cache0 evict_data[46] -pin u_ctrl0 ca_evict_data[46]
load net ca0_ev_data[47] -attr @rip evict_data[47] -pin u_cache0 evict_data[47] -pin u_ctrl0 ca_evict_data[47]
load net ca0_ev_data[48] -attr @rip evict_data[48] -pin u_cache0 evict_data[48] -pin u_ctrl0 ca_evict_data[48]
load net ca0_ev_data[49] -attr @rip evict_data[49] -pin u_cache0 evict_data[49] -pin u_ctrl0 ca_evict_data[49]
load net ca0_ev_data[4] -attr @rip evict_data[4] -pin u_cache0 evict_data[4] -pin u_ctrl0 ca_evict_data[4]
load net ca0_ev_data[50] -attr @rip evict_data[50] -pin u_cache0 evict_data[50] -pin u_ctrl0 ca_evict_data[50]
load net ca0_ev_data[51] -attr @rip evict_data[51] -pin u_cache0 evict_data[51] -pin u_ctrl0 ca_evict_data[51]
load net ca0_ev_data[52] -attr @rip evict_data[52] -pin u_cache0 evict_data[52] -pin u_ctrl0 ca_evict_data[52]
load net ca0_ev_data[53] -attr @rip evict_data[53] -pin u_cache0 evict_data[53] -pin u_ctrl0 ca_evict_data[53]
load net ca0_ev_data[54] -attr @rip evict_data[54] -pin u_cache0 evict_data[54] -pin u_ctrl0 ca_evict_data[54]
load net ca0_ev_data[55] -attr @rip evict_data[55] -pin u_cache0 evict_data[55] -pin u_ctrl0 ca_evict_data[55]
load net ca0_ev_data[56] -attr @rip evict_data[56] -pin u_cache0 evict_data[56] -pin u_ctrl0 ca_evict_data[56]
load net ca0_ev_data[57] -attr @rip evict_data[57] -pin u_cache0 evict_data[57] -pin u_ctrl0 ca_evict_data[57]
load net ca0_ev_data[58] -attr @rip evict_data[58] -pin u_cache0 evict_data[58] -pin u_ctrl0 ca_evict_data[58]
load net ca0_ev_data[59] -attr @rip evict_data[59] -pin u_cache0 evict_data[59] -pin u_ctrl0 ca_evict_data[59]
load net ca0_ev_data[5] -attr @rip evict_data[5] -pin u_cache0 evict_data[5] -pin u_ctrl0 ca_evict_data[5]
load net ca0_ev_data[60] -attr @rip evict_data[60] -pin u_cache0 evict_data[60] -pin u_ctrl0 ca_evict_data[60]
load net ca0_ev_data[61] -attr @rip evict_data[61] -pin u_cache0 evict_data[61] -pin u_ctrl0 ca_evict_data[61]
load net ca0_ev_data[62] -attr @rip evict_data[62] -pin u_cache0 evict_data[62] -pin u_ctrl0 ca_evict_data[62]
load net ca0_ev_data[63] -attr @rip evict_data[63] -pin u_cache0 evict_data[63] -pin u_ctrl0 ca_evict_data[63]
load net ca0_ev_data[6] -attr @rip evict_data[6] -pin u_cache0 evict_data[6] -pin u_ctrl0 ca_evict_data[6]
load net ca0_ev_data[7] -attr @rip evict_data[7] -pin u_cache0 evict_data[7] -pin u_ctrl0 ca_evict_data[7]
load net ca0_ev_data[8] -attr @rip evict_data[8] -pin u_cache0 evict_data[8] -pin u_ctrl0 ca_evict_data[8]
load net ca0_ev_data[9] -attr @rip evict_data[9] -pin u_cache0 evict_data[9] -pin u_ctrl0 ca_evict_data[9]
load net ca0_ev_mesi[0] -attr @rip evict_mesi[0] -pin u_cache0 evict_mesi[0] -pin u_ctrl0 ca_evict_mesi[0]
load net ca0_ev_mesi[1] -attr @rip evict_mesi[1] -pin u_cache0 evict_mesi[1] -pin u_ctrl0 ca_evict_mesi[1]
load net ca0_ev_set[0] -attr @rip ca_evict_set[0] -pin u_cache0 evict_set[0] -pin u_ctrl0 ca_evict_set[0]
load net ca0_ev_set[1] -attr @rip ca_evict_set[1] -pin u_cache0 evict_set[1] -pin u_ctrl0 ca_evict_set[1]
load net ca0_ev_way -pin u_cache0 evict_way -pin u_ctrl0 ca_evict_way
netloc ca0_ev_way 1 0 3 80 30 NJ 30 1270
load net ca0_hit -pin u_cache0 hit -pin u_ctrl0 ca_hit
netloc ca0_hit 1 1 1 610 270n
load net ca0_hit_data[0] -attr @rip hit_data[0] -pin u_cache0 hit_data[0] -pin u_ctrl0 ca_hit_data[0]
load net ca0_hit_data[10] -attr @rip hit_data[10] -pin u_cache0 hit_data[10] -pin u_ctrl0 ca_hit_data[10]
load net ca0_hit_data[11] -attr @rip hit_data[11] -pin u_cache0 hit_data[11] -pin u_ctrl0 ca_hit_data[11]
load net ca0_hit_data[12] -attr @rip hit_data[12] -pin u_cache0 hit_data[12] -pin u_ctrl0 ca_hit_data[12]
load net ca0_hit_data[13] -attr @rip hit_data[13] -pin u_cache0 hit_data[13] -pin u_ctrl0 ca_hit_data[13]
load net ca0_hit_data[14] -attr @rip hit_data[14] -pin u_cache0 hit_data[14] -pin u_ctrl0 ca_hit_data[14]
load net ca0_hit_data[15] -attr @rip hit_data[15] -pin u_cache0 hit_data[15] -pin u_ctrl0 ca_hit_data[15]
load net ca0_hit_data[16] -attr @rip hit_data[16] -pin u_cache0 hit_data[16] -pin u_ctrl0 ca_hit_data[16]
load net ca0_hit_data[17] -attr @rip hit_data[17] -pin u_cache0 hit_data[17] -pin u_ctrl0 ca_hit_data[17]
load net ca0_hit_data[18] -attr @rip hit_data[18] -pin u_cache0 hit_data[18] -pin u_ctrl0 ca_hit_data[18]
load net ca0_hit_data[19] -attr @rip hit_data[19] -pin u_cache0 hit_data[19] -pin u_ctrl0 ca_hit_data[19]
load net ca0_hit_data[1] -attr @rip hit_data[1] -pin u_cache0 hit_data[1] -pin u_ctrl0 ca_hit_data[1]
load net ca0_hit_data[20] -attr @rip hit_data[20] -pin u_cache0 hit_data[20] -pin u_ctrl0 ca_hit_data[20]
load net ca0_hit_data[21] -attr @rip hit_data[21] -pin u_cache0 hit_data[21] -pin u_ctrl0 ca_hit_data[21]
load net ca0_hit_data[22] -attr @rip hit_data[22] -pin u_cache0 hit_data[22] -pin u_ctrl0 ca_hit_data[22]
load net ca0_hit_data[23] -attr @rip hit_data[23] -pin u_cache0 hit_data[23] -pin u_ctrl0 ca_hit_data[23]
load net ca0_hit_data[24] -attr @rip hit_data[24] -pin u_cache0 hit_data[24] -pin u_ctrl0 ca_hit_data[24]
load net ca0_hit_data[25] -attr @rip hit_data[25] -pin u_cache0 hit_data[25] -pin u_ctrl0 ca_hit_data[25]
load net ca0_hit_data[26] -attr @rip hit_data[26] -pin u_cache0 hit_data[26] -pin u_ctrl0 ca_hit_data[26]
load net ca0_hit_data[27] -attr @rip hit_data[27] -pin u_cache0 hit_data[27] -pin u_ctrl0 ca_hit_data[27]
load net ca0_hit_data[28] -attr @rip hit_data[28] -pin u_cache0 hit_data[28] -pin u_ctrl0 ca_hit_data[28]
load net ca0_hit_data[29] -attr @rip hit_data[29] -pin u_cache0 hit_data[29] -pin u_ctrl0 ca_hit_data[29]
load net ca0_hit_data[2] -attr @rip hit_data[2] -pin u_cache0 hit_data[2] -pin u_ctrl0 ca_hit_data[2]
load net ca0_hit_data[30] -attr @rip hit_data[30] -pin u_cache0 hit_data[30] -pin u_ctrl0 ca_hit_data[30]
load net ca0_hit_data[31] -attr @rip hit_data[31] -pin u_cache0 hit_data[31] -pin u_ctrl0 ca_hit_data[31]
load net ca0_hit_data[32] -attr @rip hit_data[32] -pin u_cache0 hit_data[32] -pin u_ctrl0 ca_hit_data[32]
load net ca0_hit_data[33] -attr @rip hit_data[33] -pin u_cache0 hit_data[33] -pin u_ctrl0 ca_hit_data[33]
load net ca0_hit_data[34] -attr @rip hit_data[34] -pin u_cache0 hit_data[34] -pin u_ctrl0 ca_hit_data[34]
load net ca0_hit_data[35] -attr @rip hit_data[35] -pin u_cache0 hit_data[35] -pin u_ctrl0 ca_hit_data[35]
load net ca0_hit_data[36] -attr @rip hit_data[36] -pin u_cache0 hit_data[36] -pin u_ctrl0 ca_hit_data[36]
load net ca0_hit_data[37] -attr @rip hit_data[37] -pin u_cache0 hit_data[37] -pin u_ctrl0 ca_hit_data[37]
load net ca0_hit_data[38] -attr @rip hit_data[38] -pin u_cache0 hit_data[38] -pin u_ctrl0 ca_hit_data[38]
load net ca0_hit_data[39] -attr @rip hit_data[39] -pin u_cache0 hit_data[39] -pin u_ctrl0 ca_hit_data[39]
load net ca0_hit_data[3] -attr @rip hit_data[3] -pin u_cache0 hit_data[3] -pin u_ctrl0 ca_hit_data[3]
load net ca0_hit_data[40] -attr @rip hit_data[40] -pin u_cache0 hit_data[40] -pin u_ctrl0 ca_hit_data[40]
load net ca0_hit_data[41] -attr @rip hit_data[41] -pin u_cache0 hit_data[41] -pin u_ctrl0 ca_hit_data[41]
load net ca0_hit_data[42] -attr @rip hit_data[42] -pin u_cache0 hit_data[42] -pin u_ctrl0 ca_hit_data[42]
load net ca0_hit_data[43] -attr @rip hit_data[43] -pin u_cache0 hit_data[43] -pin u_ctrl0 ca_hit_data[43]
load net ca0_hit_data[44] -attr @rip hit_data[44] -pin u_cache0 hit_data[44] -pin u_ctrl0 ca_hit_data[44]
load net ca0_hit_data[45] -attr @rip hit_data[45] -pin u_cache0 hit_data[45] -pin u_ctrl0 ca_hit_data[45]
load net ca0_hit_data[46] -attr @rip hit_data[46] -pin u_cache0 hit_data[46] -pin u_ctrl0 ca_hit_data[46]
load net ca0_hit_data[47] -attr @rip hit_data[47] -pin u_cache0 hit_data[47] -pin u_ctrl0 ca_hit_data[47]
load net ca0_hit_data[48] -attr @rip hit_data[48] -pin u_cache0 hit_data[48] -pin u_ctrl0 ca_hit_data[48]
load net ca0_hit_data[49] -attr @rip hit_data[49] -pin u_cache0 hit_data[49] -pin u_ctrl0 ca_hit_data[49]
load net ca0_hit_data[4] -attr @rip hit_data[4] -pin u_cache0 hit_data[4] -pin u_ctrl0 ca_hit_data[4]
load net ca0_hit_data[50] -attr @rip hit_data[50] -pin u_cache0 hit_data[50] -pin u_ctrl0 ca_hit_data[50]
load net ca0_hit_data[51] -attr @rip hit_data[51] -pin u_cache0 hit_data[51] -pin u_ctrl0 ca_hit_data[51]
load net ca0_hit_data[52] -attr @rip hit_data[52] -pin u_cache0 hit_data[52] -pin u_ctrl0 ca_hit_data[52]
load net ca0_hit_data[53] -attr @rip hit_data[53] -pin u_cache0 hit_data[53] -pin u_ctrl0 ca_hit_data[53]
load net ca0_hit_data[54] -attr @rip hit_data[54] -pin u_cache0 hit_data[54] -pin u_ctrl0 ca_hit_data[54]
load net ca0_hit_data[55] -attr @rip hit_data[55] -pin u_cache0 hit_data[55] -pin u_ctrl0 ca_hit_data[55]
load net ca0_hit_data[56] -attr @rip hit_data[56] -pin u_cache0 hit_data[56] -pin u_ctrl0 ca_hit_data[56]
load net ca0_hit_data[57] -attr @rip hit_data[57] -pin u_cache0 hit_data[57] -pin u_ctrl0 ca_hit_data[57]
load net ca0_hit_data[58] -attr @rip hit_data[58] -pin u_cache0 hit_data[58] -pin u_ctrl0 ca_hit_data[58]
load net ca0_hit_data[59] -attr @rip hit_data[59] -pin u_cache0 hit_data[59] -pin u_ctrl0 ca_hit_data[59]
load net ca0_hit_data[5] -attr @rip hit_data[5] -pin u_cache0 hit_data[5] -pin u_ctrl0 ca_hit_data[5]
load net ca0_hit_data[60] -attr @rip hit_data[60] -pin u_cache0 hit_data[60] -pin u_ctrl0 ca_hit_data[60]
load net ca0_hit_data[61] -attr @rip hit_data[61] -pin u_cache0 hit_data[61] -pin u_ctrl0 ca_hit_data[61]
load net ca0_hit_data[62] -attr @rip hit_data[62] -pin u_cache0 hit_data[62] -pin u_ctrl0 ca_hit_data[62]
load net ca0_hit_data[63] -attr @rip hit_data[63] -pin u_cache0 hit_data[63] -pin u_ctrl0 ca_hit_data[63]
load net ca0_hit_data[6] -attr @rip hit_data[6] -pin u_cache0 hit_data[6] -pin u_ctrl0 ca_hit_data[6]
load net ca0_hit_data[7] -attr @rip hit_data[7] -pin u_cache0 hit_data[7] -pin u_ctrl0 ca_hit_data[7]
load net ca0_hit_data[8] -attr @rip hit_data[8] -pin u_cache0 hit_data[8] -pin u_ctrl0 ca_hit_data[8]
load net ca0_hit_data[9] -attr @rip hit_data[9] -pin u_cache0 hit_data[9] -pin u_ctrl0 ca_hit_data[9]
load net ca0_hit_mesi[0] -attr @rip hit_mesi[0] -pin u_cache0 hit_mesi[0] -pin u_ctrl0 ca_hit_mesi[0]
load net ca0_hit_mesi[1] -attr @rip hit_mesi[1] -pin u_cache0 hit_mesi[1] -pin u_ctrl0 ca_hit_mesi[1]
load net ca0_hit_way -pin u_cache0 hit_way -pin u_ctrl0 ca_hit_way
netloc ca0_hit_way 1 1 1 550 330n
load net ca0_lk_addr[0] -attr @rip ca_lookup_addr[0] -pin u_cache0 lookup_addr[0] -pin u_ctrl0 ca_lookup_addr[0]
load net ca0_lk_addr[1] -attr @rip ca_lookup_addr[1] -pin u_cache0 lookup_addr[1] -pin u_ctrl0 ca_lookup_addr[1]
load net ca0_lk_addr[2] -attr @rip ca_lookup_addr[2] -pin u_cache0 lookup_addr[2] -pin u_ctrl0 ca_lookup_addr[2]
load net ca0_lk_addr[3] -attr @rip ca_lookup_addr[3] -pin u_cache0 lookup_addr[3] -pin u_ctrl0 ca_lookup_addr[3]
load net ca0_lk_addr[4] -attr @rip ca_lookup_addr[4] -pin u_cache0 lookup_addr[4] -pin u_ctrl0 ca_lookup_addr[4]
load net ca0_lk_addr[5] -attr @rip ca_lookup_addr[5] -pin u_cache0 lookup_addr[5] -pin u_ctrl0 ca_lookup_addr[5]
load net ca0_lk_addr[6] -attr @rip ca_lookup_addr[6] -pin u_cache0 lookup_addr[6] -pin u_ctrl0 ca_lookup_addr[6]
load net ca0_lk_addr[7] -attr @rip ca_lookup_addr[7] -pin u_cache0 lookup_addr[7] -pin u_ctrl0 ca_lookup_addr[7]
load net ca0_lru_way -pin u_cache0 lru_way_out -pin u_ctrl0 ca_lru_way
netloc ca0_lru_way 1 1 1 530 350n
load net ca0_wr_addr[0] -attr @rip ca_write_addr[0] -pin u_cache0 write_addr[0] -pin u_ctrl0 ca_write_addr[0]
load net ca0_wr_addr[1] -attr @rip ca_write_addr[1] -pin u_cache0 write_addr[1] -pin u_ctrl0 ca_write_addr[1]
load net ca0_wr_addr[2] -attr @rip ca_write_addr[2] -pin u_cache0 write_addr[2] -pin u_ctrl0 ca_write_addr[2]
load net ca0_wr_addr[3] -attr @rip ca_write_addr[3] -pin u_cache0 write_addr[3] -pin u_ctrl0 ca_write_addr[3]
load net ca0_wr_addr[4] -attr @rip ca_write_addr[4] -pin u_cache0 write_addr[4] -pin u_ctrl0 ca_write_addr[4]
load net ca0_wr_addr[5] -attr @rip ca_write_addr[5] -pin u_cache0 write_addr[5] -pin u_ctrl0 ca_write_addr[5]
load net ca0_wr_addr[6] -attr @rip ca_write_addr[6] -pin u_cache0 write_addr[6] -pin u_ctrl0 ca_write_addr[6]
load net ca0_wr_addr[7] -attr @rip ca_write_addr[7] -pin u_cache0 write_addr[7] -pin u_ctrl0 ca_write_addr[7]
load net ca0_wr_data[0] -attr @rip ca_write_data[0] -pin u_cache0 write_data[0] -pin u_ctrl0 ca_write_data[0]
load net ca0_wr_data[10] -attr @rip ca_write_data[10] -pin u_cache0 write_data[10] -pin u_ctrl0 ca_write_data[10]
load net ca0_wr_data[11] -attr @rip ca_write_data[11] -pin u_cache0 write_data[11] -pin u_ctrl0 ca_write_data[11]
load net ca0_wr_data[12] -attr @rip ca_write_data[12] -pin u_cache0 write_data[12] -pin u_ctrl0 ca_write_data[12]
load net ca0_wr_data[13] -attr @rip ca_write_data[13] -pin u_cache0 write_data[13] -pin u_ctrl0 ca_write_data[13]
load net ca0_wr_data[14] -attr @rip ca_write_data[14] -pin u_cache0 write_data[14] -pin u_ctrl0 ca_write_data[14]
load net ca0_wr_data[15] -attr @rip ca_write_data[15] -pin u_cache0 write_data[15] -pin u_ctrl0 ca_write_data[15]
load net ca0_wr_data[16] -attr @rip ca_write_data[16] -pin u_cache0 write_data[16] -pin u_ctrl0 ca_write_data[16]
load net ca0_wr_data[17] -attr @rip ca_write_data[17] -pin u_cache0 write_data[17] -pin u_ctrl0 ca_write_data[17]
load net ca0_wr_data[18] -attr @rip ca_write_data[18] -pin u_cache0 write_data[18] -pin u_ctrl0 ca_write_data[18]
load net ca0_wr_data[19] -attr @rip ca_write_data[19] -pin u_cache0 write_data[19] -pin u_ctrl0 ca_write_data[19]
load net ca0_wr_data[1] -attr @rip ca_write_data[1] -pin u_cache0 write_data[1] -pin u_ctrl0 ca_write_data[1]
load net ca0_wr_data[20] -attr @rip ca_write_data[20] -pin u_cache0 write_data[20] -pin u_ctrl0 ca_write_data[20]
load net ca0_wr_data[21] -attr @rip ca_write_data[21] -pin u_cache0 write_data[21] -pin u_ctrl0 ca_write_data[21]
load net ca0_wr_data[22] -attr @rip ca_write_data[22] -pin u_cache0 write_data[22] -pin u_ctrl0 ca_write_data[22]
load net ca0_wr_data[23] -attr @rip ca_write_data[23] -pin u_cache0 write_data[23] -pin u_ctrl0 ca_write_data[23]
load net ca0_wr_data[24] -attr @rip ca_write_data[24] -pin u_cache0 write_data[24] -pin u_ctrl0 ca_write_data[24]
load net ca0_wr_data[25] -attr @rip ca_write_data[25] -pin u_cache0 write_data[25] -pin u_ctrl0 ca_write_data[25]
load net ca0_wr_data[26] -attr @rip ca_write_data[26] -pin u_cache0 write_data[26] -pin u_ctrl0 ca_write_data[26]
load net ca0_wr_data[27] -attr @rip ca_write_data[27] -pin u_cache0 write_data[27] -pin u_ctrl0 ca_write_data[27]
load net ca0_wr_data[28] -attr @rip ca_write_data[28] -pin u_cache0 write_data[28] -pin u_ctrl0 ca_write_data[28]
load net ca0_wr_data[29] -attr @rip ca_write_data[29] -pin u_cache0 write_data[29] -pin u_ctrl0 ca_write_data[29]
load net ca0_wr_data[2] -attr @rip ca_write_data[2] -pin u_cache0 write_data[2] -pin u_ctrl0 ca_write_data[2]
load net ca0_wr_data[30] -attr @rip ca_write_data[30] -pin u_cache0 write_data[30] -pin u_ctrl0 ca_write_data[30]
load net ca0_wr_data[31] -attr @rip ca_write_data[31] -pin u_cache0 write_data[31] -pin u_ctrl0 ca_write_data[31]
load net ca0_wr_data[32] -attr @rip ca_write_data[32] -pin u_cache0 write_data[32] -pin u_ctrl0 ca_write_data[32]
load net ca0_wr_data[33] -attr @rip ca_write_data[33] -pin u_cache0 write_data[33] -pin u_ctrl0 ca_write_data[33]
load net ca0_wr_data[34] -attr @rip ca_write_data[34] -pin u_cache0 write_data[34] -pin u_ctrl0 ca_write_data[34]
load net ca0_wr_data[35] -attr @rip ca_write_data[35] -pin u_cache0 write_data[35] -pin u_ctrl0 ca_write_data[35]
load net ca0_wr_data[36] -attr @rip ca_write_data[36] -pin u_cache0 write_data[36] -pin u_ctrl0 ca_write_data[36]
load net ca0_wr_data[37] -attr @rip ca_write_data[37] -pin u_cache0 write_data[37] -pin u_ctrl0 ca_write_data[37]
load net ca0_wr_data[38] -attr @rip ca_write_data[38] -pin u_cache0 write_data[38] -pin u_ctrl0 ca_write_data[38]
load net ca0_wr_data[39] -attr @rip ca_write_data[39] -pin u_cache0 write_data[39] -pin u_ctrl0 ca_write_data[39]
load net ca0_wr_data[3] -attr @rip ca_write_data[3] -pin u_cache0 write_data[3] -pin u_ctrl0 ca_write_data[3]
load net ca0_wr_data[40] -attr @rip ca_write_data[40] -pin u_cache0 write_data[40] -pin u_ctrl0 ca_write_data[40]
load net ca0_wr_data[41] -attr @rip ca_write_data[41] -pin u_cache0 write_data[41] -pin u_ctrl0 ca_write_data[41]
load net ca0_wr_data[42] -attr @rip ca_write_data[42] -pin u_cache0 write_data[42] -pin u_ctrl0 ca_write_data[42]
load net ca0_wr_data[43] -attr @rip ca_write_data[43] -pin u_cache0 write_data[43] -pin u_ctrl0 ca_write_data[43]
load net ca0_wr_data[44] -attr @rip ca_write_data[44] -pin u_cache0 write_data[44] -pin u_ctrl0 ca_write_data[44]
load net ca0_wr_data[45] -attr @rip ca_write_data[45] -pin u_cache0 write_data[45] -pin u_ctrl0 ca_write_data[45]
load net ca0_wr_data[46] -attr @rip ca_write_data[46] -pin u_cache0 write_data[46] -pin u_ctrl0 ca_write_data[46]
load net ca0_wr_data[47] -attr @rip ca_write_data[47] -pin u_cache0 write_data[47] -pin u_ctrl0 ca_write_data[47]
load net ca0_wr_data[48] -attr @rip ca_write_data[48] -pin u_cache0 write_data[48] -pin u_ctrl0 ca_write_data[48]
load net ca0_wr_data[49] -attr @rip ca_write_data[49] -pin u_cache0 write_data[49] -pin u_ctrl0 ca_write_data[49]
load net ca0_wr_data[4] -attr @rip ca_write_data[4] -pin u_cache0 write_data[4] -pin u_ctrl0 ca_write_data[4]
load net ca0_wr_data[50] -attr @rip ca_write_data[50] -pin u_cache0 write_data[50] -pin u_ctrl0 ca_write_data[50]
load net ca0_wr_data[51] -attr @rip ca_write_data[51] -pin u_cache0 write_data[51] -pin u_ctrl0 ca_write_data[51]
load net ca0_wr_data[52] -attr @rip ca_write_data[52] -pin u_cache0 write_data[52] -pin u_ctrl0 ca_write_data[52]
load net ca0_wr_data[53] -attr @rip ca_write_data[53] -pin u_cache0 write_data[53] -pin u_ctrl0 ca_write_data[53]
load net ca0_wr_data[54] -attr @rip ca_write_data[54] -pin u_cache0 write_data[54] -pin u_ctrl0 ca_write_data[54]
load net ca0_wr_data[55] -attr @rip ca_write_data[55] -pin u_cache0 write_data[55] -pin u_ctrl0 ca_write_data[55]
load net ca0_wr_data[56] -attr @rip ca_write_data[56] -pin u_cache0 write_data[56] -pin u_ctrl0 ca_write_data[56]
load net ca0_wr_data[57] -attr @rip ca_write_data[57] -pin u_cache0 write_data[57] -pin u_ctrl0 ca_write_data[57]
load net ca0_wr_data[58] -attr @rip ca_write_data[58] -pin u_cache0 write_data[58] -pin u_ctrl0 ca_write_data[58]
load net ca0_wr_data[59] -attr @rip ca_write_data[59] -pin u_cache0 write_data[59] -pin u_ctrl0 ca_write_data[59]
load net ca0_wr_data[5] -attr @rip ca_write_data[5] -pin u_cache0 write_data[5] -pin u_ctrl0 ca_write_data[5]
load net ca0_wr_data[60] -attr @rip ca_write_data[60] -pin u_cache0 write_data[60] -pin u_ctrl0 ca_write_data[60]
load net ca0_wr_data[61] -attr @rip ca_write_data[61] -pin u_cache0 write_data[61] -pin u_ctrl0 ca_write_data[61]
load net ca0_wr_data[62] -attr @rip ca_write_data[62] -pin u_cache0 write_data[62] -pin u_ctrl0 ca_write_data[62]
load net ca0_wr_data[63] -attr @rip ca_write_data[63] -pin u_cache0 write_data[63] -pin u_ctrl0 ca_write_data[63]
load net ca0_wr_data[6] -attr @rip ca_write_data[6] -pin u_cache0 write_data[6] -pin u_ctrl0 ca_write_data[6]
load net ca0_wr_data[7] -attr @rip ca_write_data[7] -pin u_cache0 write_data[7] -pin u_ctrl0 ca_write_data[7]
load net ca0_wr_data[8] -attr @rip ca_write_data[8] -pin u_cache0 write_data[8] -pin u_ctrl0 ca_write_data[8]
load net ca0_wr_data[9] -attr @rip ca_write_data[9] -pin u_cache0 write_data[9] -pin u_ctrl0 ca_write_data[9]
load net ca0_wr_en -pin u_cache0 write_en -pin u_ctrl0 ca_write_en
netloc ca0_wr_en 1 0 3 160 110 NJ 110 1170
load net ca0_wr_mesi[0] -attr @rip ca_write_mesi[0] -pin u_cache0 write_mesi[0] -pin u_ctrl0 ca_write_mesi[0]
load net ca0_wr_mesi[1] -attr @rip ca_write_mesi[1] -pin u_cache0 write_mesi[1] -pin u_ctrl0 ca_write_mesi[1]
load net ca0_wr_way -pin u_cache0 write_way -pin u_ctrl0 ca_write_way
netloc ca0_wr_way 1 0 3 180 410 510J 150 1110
load net ca1_ev_addr[0] -attr @rip evict_addr_out[0] -pin u_cache1 evict_addr_out[0] -pin u_ctrl1 ca_evict_addr[0]
load net ca1_ev_addr[1] -attr @rip evict_addr_out[1] -pin u_cache1 evict_addr_out[1] -pin u_ctrl1 ca_evict_addr[1]
load net ca1_ev_addr[2] -attr @rip evict_addr_out[2] -pin u_cache1 evict_addr_out[2] -pin u_ctrl1 ca_evict_addr[2]
load net ca1_ev_addr[3] -attr @rip evict_addr_out[3] -pin u_cache1 evict_addr_out[3] -pin u_ctrl1 ca_evict_addr[3]
load net ca1_ev_addr[4] -attr @rip evict_addr_out[4] -pin u_cache1 evict_addr_out[4] -pin u_ctrl1 ca_evict_addr[4]
load net ca1_ev_addr[5] -attr @rip evict_addr_out[5] -pin u_cache1 evict_addr_out[5] -pin u_ctrl1 ca_evict_addr[5]
load net ca1_ev_addr[6] -attr @rip evict_addr_out[6] -pin u_cache1 evict_addr_out[6] -pin u_ctrl1 ca_evict_addr[6]
load net ca1_ev_addr[7] -attr @rip evict_addr_out[7] -pin u_cache1 evict_addr_out[7] -pin u_ctrl1 ca_evict_addr[7]
load net ca1_ev_data[0] -attr @rip evict_data[0] -pin u_cache1 evict_data[0] -pin u_ctrl1 ca_evict_data[0]
load net ca1_ev_data[10] -attr @rip evict_data[10] -pin u_cache1 evict_data[10] -pin u_ctrl1 ca_evict_data[10]
load net ca1_ev_data[11] -attr @rip evict_data[11] -pin u_cache1 evict_data[11] -pin u_ctrl1 ca_evict_data[11]
load net ca1_ev_data[12] -attr @rip evict_data[12] -pin u_cache1 evict_data[12] -pin u_ctrl1 ca_evict_data[12]
load net ca1_ev_data[13] -attr @rip evict_data[13] -pin u_cache1 evict_data[13] -pin u_ctrl1 ca_evict_data[13]
load net ca1_ev_data[14] -attr @rip evict_data[14] -pin u_cache1 evict_data[14] -pin u_ctrl1 ca_evict_data[14]
load net ca1_ev_data[15] -attr @rip evict_data[15] -pin u_cache1 evict_data[15] -pin u_ctrl1 ca_evict_data[15]
load net ca1_ev_data[16] -attr @rip evict_data[16] -pin u_cache1 evict_data[16] -pin u_ctrl1 ca_evict_data[16]
load net ca1_ev_data[17] -attr @rip evict_data[17] -pin u_cache1 evict_data[17] -pin u_ctrl1 ca_evict_data[17]
load net ca1_ev_data[18] -attr @rip evict_data[18] -pin u_cache1 evict_data[18] -pin u_ctrl1 ca_evict_data[18]
load net ca1_ev_data[19] -attr @rip evict_data[19] -pin u_cache1 evict_data[19] -pin u_ctrl1 ca_evict_data[19]
load net ca1_ev_data[1] -attr @rip evict_data[1] -pin u_cache1 evict_data[1] -pin u_ctrl1 ca_evict_data[1]
load net ca1_ev_data[20] -attr @rip evict_data[20] -pin u_cache1 evict_data[20] -pin u_ctrl1 ca_evict_data[20]
load net ca1_ev_data[21] -attr @rip evict_data[21] -pin u_cache1 evict_data[21] -pin u_ctrl1 ca_evict_data[21]
load net ca1_ev_data[22] -attr @rip evict_data[22] -pin u_cache1 evict_data[22] -pin u_ctrl1 ca_evict_data[22]
load net ca1_ev_data[23] -attr @rip evict_data[23] -pin u_cache1 evict_data[23] -pin u_ctrl1 ca_evict_data[23]
load net ca1_ev_data[24] -attr @rip evict_data[24] -pin u_cache1 evict_data[24] -pin u_ctrl1 ca_evict_data[24]
load net ca1_ev_data[25] -attr @rip evict_data[25] -pin u_cache1 evict_data[25] -pin u_ctrl1 ca_evict_data[25]
load net ca1_ev_data[26] -attr @rip evict_data[26] -pin u_cache1 evict_data[26] -pin u_ctrl1 ca_evict_data[26]
load net ca1_ev_data[27] -attr @rip evict_data[27] -pin u_cache1 evict_data[27] -pin u_ctrl1 ca_evict_data[27]
load net ca1_ev_data[28] -attr @rip evict_data[28] -pin u_cache1 evict_data[28] -pin u_ctrl1 ca_evict_data[28]
load net ca1_ev_data[29] -attr @rip evict_data[29] -pin u_cache1 evict_data[29] -pin u_ctrl1 ca_evict_data[29]
load net ca1_ev_data[2] -attr @rip evict_data[2] -pin u_cache1 evict_data[2] -pin u_ctrl1 ca_evict_data[2]
load net ca1_ev_data[30] -attr @rip evict_data[30] -pin u_cache1 evict_data[30] -pin u_ctrl1 ca_evict_data[30]
load net ca1_ev_data[31] -attr @rip evict_data[31] -pin u_cache1 evict_data[31] -pin u_ctrl1 ca_evict_data[31]
load net ca1_ev_data[32] -attr @rip evict_data[32] -pin u_cache1 evict_data[32] -pin u_ctrl1 ca_evict_data[32]
load net ca1_ev_data[33] -attr @rip evict_data[33] -pin u_cache1 evict_data[33] -pin u_ctrl1 ca_evict_data[33]
load net ca1_ev_data[34] -attr @rip evict_data[34] -pin u_cache1 evict_data[34] -pin u_ctrl1 ca_evict_data[34]
load net ca1_ev_data[35] -attr @rip evict_data[35] -pin u_cache1 evict_data[35] -pin u_ctrl1 ca_evict_data[35]
load net ca1_ev_data[36] -attr @rip evict_data[36] -pin u_cache1 evict_data[36] -pin u_ctrl1 ca_evict_data[36]
load net ca1_ev_data[37] -attr @rip evict_data[37] -pin u_cache1 evict_data[37] -pin u_ctrl1 ca_evict_data[37]
load net ca1_ev_data[38] -attr @rip evict_data[38] -pin u_cache1 evict_data[38] -pin u_ctrl1 ca_evict_data[38]
load net ca1_ev_data[39] -attr @rip evict_data[39] -pin u_cache1 evict_data[39] -pin u_ctrl1 ca_evict_data[39]
load net ca1_ev_data[3] -attr @rip evict_data[3] -pin u_cache1 evict_data[3] -pin u_ctrl1 ca_evict_data[3]
load net ca1_ev_data[40] -attr @rip evict_data[40] -pin u_cache1 evict_data[40] -pin u_ctrl1 ca_evict_data[40]
load net ca1_ev_data[41] -attr @rip evict_data[41] -pin u_cache1 evict_data[41] -pin u_ctrl1 ca_evict_data[41]
load net ca1_ev_data[42] -attr @rip evict_data[42] -pin u_cache1 evict_data[42] -pin u_ctrl1 ca_evict_data[42]
load net ca1_ev_data[43] -attr @rip evict_data[43] -pin u_cache1 evict_data[43] -pin u_ctrl1 ca_evict_data[43]
load net ca1_ev_data[44] -attr @rip evict_data[44] -pin u_cache1 evict_data[44] -pin u_ctrl1 ca_evict_data[44]
load net ca1_ev_data[45] -attr @rip evict_data[45] -pin u_cache1 evict_data[45] -pin u_ctrl1 ca_evict_data[45]
load net ca1_ev_data[46] -attr @rip evict_data[46] -pin u_cache1 evict_data[46] -pin u_ctrl1 ca_evict_data[46]
load net ca1_ev_data[47] -attr @rip evict_data[47] -pin u_cache1 evict_data[47] -pin u_ctrl1 ca_evict_data[47]
load net ca1_ev_data[48] -attr @rip evict_data[48] -pin u_cache1 evict_data[48] -pin u_ctrl1 ca_evict_data[48]
load net ca1_ev_data[49] -attr @rip evict_data[49] -pin u_cache1 evict_data[49] -pin u_ctrl1 ca_evict_data[49]
load net ca1_ev_data[4] -attr @rip evict_data[4] -pin u_cache1 evict_data[4] -pin u_ctrl1 ca_evict_data[4]
load net ca1_ev_data[50] -attr @rip evict_data[50] -pin u_cache1 evict_data[50] -pin u_ctrl1 ca_evict_data[50]
load net ca1_ev_data[51] -attr @rip evict_data[51] -pin u_cache1 evict_data[51] -pin u_ctrl1 ca_evict_data[51]
load net ca1_ev_data[52] -attr @rip evict_data[52] -pin u_cache1 evict_data[52] -pin u_ctrl1 ca_evict_data[52]
load net ca1_ev_data[53] -attr @rip evict_data[53] -pin u_cache1 evict_data[53] -pin u_ctrl1 ca_evict_data[53]
load net ca1_ev_data[54] -attr @rip evict_data[54] -pin u_cache1 evict_data[54] -pin u_ctrl1 ca_evict_data[54]
load net ca1_ev_data[55] -attr @rip evict_data[55] -pin u_cache1 evict_data[55] -pin u_ctrl1 ca_evict_data[55]
load net ca1_ev_data[56] -attr @rip evict_data[56] -pin u_cache1 evict_data[56] -pin u_ctrl1 ca_evict_data[56]
load net ca1_ev_data[57] -attr @rip evict_data[57] -pin u_cache1 evict_data[57] -pin u_ctrl1 ca_evict_data[57]
load net ca1_ev_data[58] -attr @rip evict_data[58] -pin u_cache1 evict_data[58] -pin u_ctrl1 ca_evict_data[58]
load net ca1_ev_data[59] -attr @rip evict_data[59] -pin u_cache1 evict_data[59] -pin u_ctrl1 ca_evict_data[59]
load net ca1_ev_data[5] -attr @rip evict_data[5] -pin u_cache1 evict_data[5] -pin u_ctrl1 ca_evict_data[5]
load net ca1_ev_data[60] -attr @rip evict_data[60] -pin u_cache1 evict_data[60] -pin u_ctrl1 ca_evict_data[60]
load net ca1_ev_data[61] -attr @rip evict_data[61] -pin u_cache1 evict_data[61] -pin u_ctrl1 ca_evict_data[61]
load net ca1_ev_data[62] -attr @rip evict_data[62] -pin u_cache1 evict_data[62] -pin u_ctrl1 ca_evict_data[62]
load net ca1_ev_data[63] -attr @rip evict_data[63] -pin u_cache1 evict_data[63] -pin u_ctrl1 ca_evict_data[63]
load net ca1_ev_data[6] -attr @rip evict_data[6] -pin u_cache1 evict_data[6] -pin u_ctrl1 ca_evict_data[6]
load net ca1_ev_data[7] -attr @rip evict_data[7] -pin u_cache1 evict_data[7] -pin u_ctrl1 ca_evict_data[7]
load net ca1_ev_data[8] -attr @rip evict_data[8] -pin u_cache1 evict_data[8] -pin u_ctrl1 ca_evict_data[8]
load net ca1_ev_data[9] -attr @rip evict_data[9] -pin u_cache1 evict_data[9] -pin u_ctrl1 ca_evict_data[9]
load net ca1_ev_mesi[0] -attr @rip evict_mesi[0] -pin u_cache1 evict_mesi[0] -pin u_ctrl1 ca_evict_mesi[0]
load net ca1_ev_mesi[1] -attr @rip evict_mesi[1] -pin u_cache1 evict_mesi[1] -pin u_ctrl1 ca_evict_mesi[1]
load net ca1_ev_set[0] -attr @rip ca_evict_set[0] -pin u_cache1 evict_set[0] -pin u_ctrl1 ca_evict_set[0]
load net ca1_ev_set[1] -attr @rip ca_evict_set[1] -pin u_cache1 evict_set[1] -pin u_ctrl1 ca_evict_set[1]
load net ca1_ev_way -pin u_cache1 evict_way -pin u_ctrl1 ca_evict_way
netloc ca1_ev_way 1 0 3 180 670 NJ 670 1130
load net ca1_hit -pin u_cache1 hit -pin u_ctrl1 ca_hit
netloc ca1_hit 1 1 1 N 850
load net ca1_hit_data[0] -attr @rip hit_data[0] -pin u_cache1 hit_data[0] -pin u_ctrl1 ca_hit_data[0]
load net ca1_hit_data[10] -attr @rip hit_data[10] -pin u_cache1 hit_data[10] -pin u_ctrl1 ca_hit_data[10]
load net ca1_hit_data[11] -attr @rip hit_data[11] -pin u_cache1 hit_data[11] -pin u_ctrl1 ca_hit_data[11]
load net ca1_hit_data[12] -attr @rip hit_data[12] -pin u_cache1 hit_data[12] -pin u_ctrl1 ca_hit_data[12]
load net ca1_hit_data[13] -attr @rip hit_data[13] -pin u_cache1 hit_data[13] -pin u_ctrl1 ca_hit_data[13]
load net ca1_hit_data[14] -attr @rip hit_data[14] -pin u_cache1 hit_data[14] -pin u_ctrl1 ca_hit_data[14]
load net ca1_hit_data[15] -attr @rip hit_data[15] -pin u_cache1 hit_data[15] -pin u_ctrl1 ca_hit_data[15]
load net ca1_hit_data[16] -attr @rip hit_data[16] -pin u_cache1 hit_data[16] -pin u_ctrl1 ca_hit_data[16]
load net ca1_hit_data[17] -attr @rip hit_data[17] -pin u_cache1 hit_data[17] -pin u_ctrl1 ca_hit_data[17]
load net ca1_hit_data[18] -attr @rip hit_data[18] -pin u_cache1 hit_data[18] -pin u_ctrl1 ca_hit_data[18]
load net ca1_hit_data[19] -attr @rip hit_data[19] -pin u_cache1 hit_data[19] -pin u_ctrl1 ca_hit_data[19]
load net ca1_hit_data[1] -attr @rip hit_data[1] -pin u_cache1 hit_data[1] -pin u_ctrl1 ca_hit_data[1]
load net ca1_hit_data[20] -attr @rip hit_data[20] -pin u_cache1 hit_data[20] -pin u_ctrl1 ca_hit_data[20]
load net ca1_hit_data[21] -attr @rip hit_data[21] -pin u_cache1 hit_data[21] -pin u_ctrl1 ca_hit_data[21]
load net ca1_hit_data[22] -attr @rip hit_data[22] -pin u_cache1 hit_data[22] -pin u_ctrl1 ca_hit_data[22]
load net ca1_hit_data[23] -attr @rip hit_data[23] -pin u_cache1 hit_data[23] -pin u_ctrl1 ca_hit_data[23]
load net ca1_hit_data[24] -attr @rip hit_data[24] -pin u_cache1 hit_data[24] -pin u_ctrl1 ca_hit_data[24]
load net ca1_hit_data[25] -attr @rip hit_data[25] -pin u_cache1 hit_data[25] -pin u_ctrl1 ca_hit_data[25]
load net ca1_hit_data[26] -attr @rip hit_data[26] -pin u_cache1 hit_data[26] -pin u_ctrl1 ca_hit_data[26]
load net ca1_hit_data[27] -attr @rip hit_data[27] -pin u_cache1 hit_data[27] -pin u_ctrl1 ca_hit_data[27]
load net ca1_hit_data[28] -attr @rip hit_data[28] -pin u_cache1 hit_data[28] -pin u_ctrl1 ca_hit_data[28]
load net ca1_hit_data[29] -attr @rip hit_data[29] -pin u_cache1 hit_data[29] -pin u_ctrl1 ca_hit_data[29]
load net ca1_hit_data[2] -attr @rip hit_data[2] -pin u_cache1 hit_data[2] -pin u_ctrl1 ca_hit_data[2]
load net ca1_hit_data[30] -attr @rip hit_data[30] -pin u_cache1 hit_data[30] -pin u_ctrl1 ca_hit_data[30]
load net ca1_hit_data[31] -attr @rip hit_data[31] -pin u_cache1 hit_data[31] -pin u_ctrl1 ca_hit_data[31]
load net ca1_hit_data[32] -attr @rip hit_data[32] -pin u_cache1 hit_data[32] -pin u_ctrl1 ca_hit_data[32]
load net ca1_hit_data[33] -attr @rip hit_data[33] -pin u_cache1 hit_data[33] -pin u_ctrl1 ca_hit_data[33]
load net ca1_hit_data[34] -attr @rip hit_data[34] -pin u_cache1 hit_data[34] -pin u_ctrl1 ca_hit_data[34]
load net ca1_hit_data[35] -attr @rip hit_data[35] -pin u_cache1 hit_data[35] -pin u_ctrl1 ca_hit_data[35]
load net ca1_hit_data[36] -attr @rip hit_data[36] -pin u_cache1 hit_data[36] -pin u_ctrl1 ca_hit_data[36]
load net ca1_hit_data[37] -attr @rip hit_data[37] -pin u_cache1 hit_data[37] -pin u_ctrl1 ca_hit_data[37]
load net ca1_hit_data[38] -attr @rip hit_data[38] -pin u_cache1 hit_data[38] -pin u_ctrl1 ca_hit_data[38]
load net ca1_hit_data[39] -attr @rip hit_data[39] -pin u_cache1 hit_data[39] -pin u_ctrl1 ca_hit_data[39]
load net ca1_hit_data[3] -attr @rip hit_data[3] -pin u_cache1 hit_data[3] -pin u_ctrl1 ca_hit_data[3]
load net ca1_hit_data[40] -attr @rip hit_data[40] -pin u_cache1 hit_data[40] -pin u_ctrl1 ca_hit_data[40]
load net ca1_hit_data[41] -attr @rip hit_data[41] -pin u_cache1 hit_data[41] -pin u_ctrl1 ca_hit_data[41]
load net ca1_hit_data[42] -attr @rip hit_data[42] -pin u_cache1 hit_data[42] -pin u_ctrl1 ca_hit_data[42]
load net ca1_hit_data[43] -attr @rip hit_data[43] -pin u_cache1 hit_data[43] -pin u_ctrl1 ca_hit_data[43]
load net ca1_hit_data[44] -attr @rip hit_data[44] -pin u_cache1 hit_data[44] -pin u_ctrl1 ca_hit_data[44]
load net ca1_hit_data[45] -attr @rip hit_data[45] -pin u_cache1 hit_data[45] -pin u_ctrl1 ca_hit_data[45]
load net ca1_hit_data[46] -attr @rip hit_data[46] -pin u_cache1 hit_data[46] -pin u_ctrl1 ca_hit_data[46]
load net ca1_hit_data[47] -attr @rip hit_data[47] -pin u_cache1 hit_data[47] -pin u_ctrl1 ca_hit_data[47]
load net ca1_hit_data[48] -attr @rip hit_data[48] -pin u_cache1 hit_data[48] -pin u_ctrl1 ca_hit_data[48]
load net ca1_hit_data[49] -attr @rip hit_data[49] -pin u_cache1 hit_data[49] -pin u_ctrl1 ca_hit_data[49]
load net ca1_hit_data[4] -attr @rip hit_data[4] -pin u_cache1 hit_data[4] -pin u_ctrl1 ca_hit_data[4]
load net ca1_hit_data[50] -attr @rip hit_data[50] -pin u_cache1 hit_data[50] -pin u_ctrl1 ca_hit_data[50]
load net ca1_hit_data[51] -attr @rip hit_data[51] -pin u_cache1 hit_data[51] -pin u_ctrl1 ca_hit_data[51]
load net ca1_hit_data[52] -attr @rip hit_data[52] -pin u_cache1 hit_data[52] -pin u_ctrl1 ca_hit_data[52]
load net ca1_hit_data[53] -attr @rip hit_data[53] -pin u_cache1 hit_data[53] -pin u_ctrl1 ca_hit_data[53]
load net ca1_hit_data[54] -attr @rip hit_data[54] -pin u_cache1 hit_data[54] -pin u_ctrl1 ca_hit_data[54]
load net ca1_hit_data[55] -attr @rip hit_data[55] -pin u_cache1 hit_data[55] -pin u_ctrl1 ca_hit_data[55]
load net ca1_hit_data[56] -attr @rip hit_data[56] -pin u_cache1 hit_data[56] -pin u_ctrl1 ca_hit_data[56]
load net ca1_hit_data[57] -attr @rip hit_data[57] -pin u_cache1 hit_data[57] -pin u_ctrl1 ca_hit_data[57]
load net ca1_hit_data[58] -attr @rip hit_data[58] -pin u_cache1 hit_data[58] -pin u_ctrl1 ca_hit_data[58]
load net ca1_hit_data[59] -attr @rip hit_data[59] -pin u_cache1 hit_data[59] -pin u_ctrl1 ca_hit_data[59]
load net ca1_hit_data[5] -attr @rip hit_data[5] -pin u_cache1 hit_data[5] -pin u_ctrl1 ca_hit_data[5]
load net ca1_hit_data[60] -attr @rip hit_data[60] -pin u_cache1 hit_data[60] -pin u_ctrl1 ca_hit_data[60]
load net ca1_hit_data[61] -attr @rip hit_data[61] -pin u_cache1 hit_data[61] -pin u_ctrl1 ca_hit_data[61]
load net ca1_hit_data[62] -attr @rip hit_data[62] -pin u_cache1 hit_data[62] -pin u_ctrl1 ca_hit_data[62]
load net ca1_hit_data[63] -attr @rip hit_data[63] -pin u_cache1 hit_data[63] -pin u_ctrl1 ca_hit_data[63]
load net ca1_hit_data[6] -attr @rip hit_data[6] -pin u_cache1 hit_data[6] -pin u_ctrl1 ca_hit_data[6]
load net ca1_hit_data[7] -attr @rip hit_data[7] -pin u_cache1 hit_data[7] -pin u_ctrl1 ca_hit_data[7]
load net ca1_hit_data[8] -attr @rip hit_data[8] -pin u_cache1 hit_data[8] -pin u_ctrl1 ca_hit_data[8]
load net ca1_hit_data[9] -attr @rip hit_data[9] -pin u_cache1 hit_data[9] -pin u_ctrl1 ca_hit_data[9]
load net ca1_hit_mesi[0] -attr @rip hit_mesi[0] -pin u_cache1 hit_mesi[0] -pin u_ctrl1 ca_hit_mesi[0]
load net ca1_hit_mesi[1] -attr @rip hit_mesi[1] -pin u_cache1 hit_mesi[1] -pin u_ctrl1 ca_hit_mesi[1]
load net ca1_hit_way -pin u_cache1 hit_way -pin u_ctrl1 ca_hit_way
netloc ca1_hit_way 1 1 1 N 910
load net ca1_lk_addr[0] -attr @rip ca_lookup_addr[0] -pin u_cache1 lookup_addr[0] -pin u_ctrl1 ca_lookup_addr[0]
load net ca1_lk_addr[1] -attr @rip ca_lookup_addr[1] -pin u_cache1 lookup_addr[1] -pin u_ctrl1 ca_lookup_addr[1]
load net ca1_lk_addr[2] -attr @rip ca_lookup_addr[2] -pin u_cache1 lookup_addr[2] -pin u_ctrl1 ca_lookup_addr[2]
load net ca1_lk_addr[3] -attr @rip ca_lookup_addr[3] -pin u_cache1 lookup_addr[3] -pin u_ctrl1 ca_lookup_addr[3]
load net ca1_lk_addr[4] -attr @rip ca_lookup_addr[4] -pin u_cache1 lookup_addr[4] -pin u_ctrl1 ca_lookup_addr[4]
load net ca1_lk_addr[5] -attr @rip ca_lookup_addr[5] -pin u_cache1 lookup_addr[5] -pin u_ctrl1 ca_lookup_addr[5]
load net ca1_lk_addr[6] -attr @rip ca_lookup_addr[6] -pin u_cache1 lookup_addr[6] -pin u_ctrl1 ca_lookup_addr[6]
load net ca1_lk_addr[7] -attr @rip ca_lookup_addr[7] -pin u_cache1 lookup_addr[7] -pin u_ctrl1 ca_lookup_addr[7]
load net ca1_lru_way -pin u_cache1 lru_way_out -pin u_ctrl1 ca_lru_way
netloc ca1_lru_way 1 1 1 N 930
load net ca1_wr_addr[0] -attr @rip ca_write_addr[0] -pin u_cache1 write_addr[0] -pin u_ctrl1 ca_write_addr[0]
load net ca1_wr_addr[1] -attr @rip ca_write_addr[1] -pin u_cache1 write_addr[1] -pin u_ctrl1 ca_write_addr[1]
load net ca1_wr_addr[2] -attr @rip ca_write_addr[2] -pin u_cache1 write_addr[2] -pin u_ctrl1 ca_write_addr[2]
load net ca1_wr_addr[3] -attr @rip ca_write_addr[3] -pin u_cache1 write_addr[3] -pin u_ctrl1 ca_write_addr[3]
load net ca1_wr_addr[4] -attr @rip ca_write_addr[4] -pin u_cache1 write_addr[4] -pin u_ctrl1 ca_write_addr[4]
load net ca1_wr_addr[5] -attr @rip ca_write_addr[5] -pin u_cache1 write_addr[5] -pin u_ctrl1 ca_write_addr[5]
load net ca1_wr_addr[6] -attr @rip ca_write_addr[6] -pin u_cache1 write_addr[6] -pin u_ctrl1 ca_write_addr[6]
load net ca1_wr_addr[7] -attr @rip ca_write_addr[7] -pin u_cache1 write_addr[7] -pin u_ctrl1 ca_write_addr[7]
load net ca1_wr_data[0] -attr @rip ca_write_data[0] -pin u_cache1 write_data[0] -pin u_ctrl1 ca_write_data[0]
load net ca1_wr_data[10] -attr @rip ca_write_data[10] -pin u_cache1 write_data[10] -pin u_ctrl1 ca_write_data[10]
load net ca1_wr_data[11] -attr @rip ca_write_data[11] -pin u_cache1 write_data[11] -pin u_ctrl1 ca_write_data[11]
load net ca1_wr_data[12] -attr @rip ca_write_data[12] -pin u_cache1 write_data[12] -pin u_ctrl1 ca_write_data[12]
load net ca1_wr_data[13] -attr @rip ca_write_data[13] -pin u_cache1 write_data[13] -pin u_ctrl1 ca_write_data[13]
load net ca1_wr_data[14] -attr @rip ca_write_data[14] -pin u_cache1 write_data[14] -pin u_ctrl1 ca_write_data[14]
load net ca1_wr_data[15] -attr @rip ca_write_data[15] -pin u_cache1 write_data[15] -pin u_ctrl1 ca_write_data[15]
load net ca1_wr_data[16] -attr @rip ca_write_data[16] -pin u_cache1 write_data[16] -pin u_ctrl1 ca_write_data[16]
load net ca1_wr_data[17] -attr @rip ca_write_data[17] -pin u_cache1 write_data[17] -pin u_ctrl1 ca_write_data[17]
load net ca1_wr_data[18] -attr @rip ca_write_data[18] -pin u_cache1 write_data[18] -pin u_ctrl1 ca_write_data[18]
load net ca1_wr_data[19] -attr @rip ca_write_data[19] -pin u_cache1 write_data[19] -pin u_ctrl1 ca_write_data[19]
load net ca1_wr_data[1] -attr @rip ca_write_data[1] -pin u_cache1 write_data[1] -pin u_ctrl1 ca_write_data[1]
load net ca1_wr_data[20] -attr @rip ca_write_data[20] -pin u_cache1 write_data[20] -pin u_ctrl1 ca_write_data[20]
load net ca1_wr_data[21] -attr @rip ca_write_data[21] -pin u_cache1 write_data[21] -pin u_ctrl1 ca_write_data[21]
load net ca1_wr_data[22] -attr @rip ca_write_data[22] -pin u_cache1 write_data[22] -pin u_ctrl1 ca_write_data[22]
load net ca1_wr_data[23] -attr @rip ca_write_data[23] -pin u_cache1 write_data[23] -pin u_ctrl1 ca_write_data[23]
load net ca1_wr_data[24] -attr @rip ca_write_data[24] -pin u_cache1 write_data[24] -pin u_ctrl1 ca_write_data[24]
load net ca1_wr_data[25] -attr @rip ca_write_data[25] -pin u_cache1 write_data[25] -pin u_ctrl1 ca_write_data[25]
load net ca1_wr_data[26] -attr @rip ca_write_data[26] -pin u_cache1 write_data[26] -pin u_ctrl1 ca_write_data[26]
load net ca1_wr_data[27] -attr @rip ca_write_data[27] -pin u_cache1 write_data[27] -pin u_ctrl1 ca_write_data[27]
load net ca1_wr_data[28] -attr @rip ca_write_data[28] -pin u_cache1 write_data[28] -pin u_ctrl1 ca_write_data[28]
load net ca1_wr_data[29] -attr @rip ca_write_data[29] -pin u_cache1 write_data[29] -pin u_ctrl1 ca_write_data[29]
load net ca1_wr_data[2] -attr @rip ca_write_data[2] -pin u_cache1 write_data[2] -pin u_ctrl1 ca_write_data[2]
load net ca1_wr_data[30] -attr @rip ca_write_data[30] -pin u_cache1 write_data[30] -pin u_ctrl1 ca_write_data[30]
load net ca1_wr_data[31] -attr @rip ca_write_data[31] -pin u_cache1 write_data[31] -pin u_ctrl1 ca_write_data[31]
load net ca1_wr_data[32] -attr @rip ca_write_data[32] -pin u_cache1 write_data[32] -pin u_ctrl1 ca_write_data[32]
load net ca1_wr_data[33] -attr @rip ca_write_data[33] -pin u_cache1 write_data[33] -pin u_ctrl1 ca_write_data[33]
load net ca1_wr_data[34] -attr @rip ca_write_data[34] -pin u_cache1 write_data[34] -pin u_ctrl1 ca_write_data[34]
load net ca1_wr_data[35] -attr @rip ca_write_data[35] -pin u_cache1 write_data[35] -pin u_ctrl1 ca_write_data[35]
load net ca1_wr_data[36] -attr @rip ca_write_data[36] -pin u_cache1 write_data[36] -pin u_ctrl1 ca_write_data[36]
load net ca1_wr_data[37] -attr @rip ca_write_data[37] -pin u_cache1 write_data[37] -pin u_ctrl1 ca_write_data[37]
load net ca1_wr_data[38] -attr @rip ca_write_data[38] -pin u_cache1 write_data[38] -pin u_ctrl1 ca_write_data[38]
load net ca1_wr_data[39] -attr @rip ca_write_data[39] -pin u_cache1 write_data[39] -pin u_ctrl1 ca_write_data[39]
load net ca1_wr_data[3] -attr @rip ca_write_data[3] -pin u_cache1 write_data[3] -pin u_ctrl1 ca_write_data[3]
load net ca1_wr_data[40] -attr @rip ca_write_data[40] -pin u_cache1 write_data[40] -pin u_ctrl1 ca_write_data[40]
load net ca1_wr_data[41] -attr @rip ca_write_data[41] -pin u_cache1 write_data[41] -pin u_ctrl1 ca_write_data[41]
load net ca1_wr_data[42] -attr @rip ca_write_data[42] -pin u_cache1 write_data[42] -pin u_ctrl1 ca_write_data[42]
load net ca1_wr_data[43] -attr @rip ca_write_data[43] -pin u_cache1 write_data[43] -pin u_ctrl1 ca_write_data[43]
load net ca1_wr_data[44] -attr @rip ca_write_data[44] -pin u_cache1 write_data[44] -pin u_ctrl1 ca_write_data[44]
load net ca1_wr_data[45] -attr @rip ca_write_data[45] -pin u_cache1 write_data[45] -pin u_ctrl1 ca_write_data[45]
load net ca1_wr_data[46] -attr @rip ca_write_data[46] -pin u_cache1 write_data[46] -pin u_ctrl1 ca_write_data[46]
load net ca1_wr_data[47] -attr @rip ca_write_data[47] -pin u_cache1 write_data[47] -pin u_ctrl1 ca_write_data[47]
load net ca1_wr_data[48] -attr @rip ca_write_data[48] -pin u_cache1 write_data[48] -pin u_ctrl1 ca_write_data[48]
load net ca1_wr_data[49] -attr @rip ca_write_data[49] -pin u_cache1 write_data[49] -pin u_ctrl1 ca_write_data[49]
load net ca1_wr_data[4] -attr @rip ca_write_data[4] -pin u_cache1 write_data[4] -pin u_ctrl1 ca_write_data[4]
load net ca1_wr_data[50] -attr @rip ca_write_data[50] -pin u_cache1 write_data[50] -pin u_ctrl1 ca_write_data[50]
load net ca1_wr_data[51] -attr @rip ca_write_data[51] -pin u_cache1 write_data[51] -pin u_ctrl1 ca_write_data[51]
load net ca1_wr_data[52] -attr @rip ca_write_data[52] -pin u_cache1 write_data[52] -pin u_ctrl1 ca_write_data[52]
load net ca1_wr_data[53] -attr @rip ca_write_data[53] -pin u_cache1 write_data[53] -pin u_ctrl1 ca_write_data[53]
load net ca1_wr_data[54] -attr @rip ca_write_data[54] -pin u_cache1 write_data[54] -pin u_ctrl1 ca_write_data[54]
load net ca1_wr_data[55] -attr @rip ca_write_data[55] -pin u_cache1 write_data[55] -pin u_ctrl1 ca_write_data[55]
load net ca1_wr_data[56] -attr @rip ca_write_data[56] -pin u_cache1 write_data[56] -pin u_ctrl1 ca_write_data[56]
load net ca1_wr_data[57] -attr @rip ca_write_data[57] -pin u_cache1 write_data[57] -pin u_ctrl1 ca_write_data[57]
load net ca1_wr_data[58] -attr @rip ca_write_data[58] -pin u_cache1 write_data[58] -pin u_ctrl1 ca_write_data[58]
load net ca1_wr_data[59] -attr @rip ca_write_data[59] -pin u_cache1 write_data[59] -pin u_ctrl1 ca_write_data[59]
load net ca1_wr_data[5] -attr @rip ca_write_data[5] -pin u_cache1 write_data[5] -pin u_ctrl1 ca_write_data[5]
load net ca1_wr_data[60] -attr @rip ca_write_data[60] -pin u_cache1 write_data[60] -pin u_ctrl1 ca_write_data[60]
load net ca1_wr_data[61] -attr @rip ca_write_data[61] -pin u_cache1 write_data[61] -pin u_ctrl1 ca_write_data[61]
load net ca1_wr_data[62] -attr @rip ca_write_data[62] -pin u_cache1 write_data[62] -pin u_ctrl1 ca_write_data[62]
load net ca1_wr_data[63] -attr @rip ca_write_data[63] -pin u_cache1 write_data[63] -pin u_ctrl1 ca_write_data[63]
load net ca1_wr_data[6] -attr @rip ca_write_data[6] -pin u_cache1 write_data[6] -pin u_ctrl1 ca_write_data[6]
load net ca1_wr_data[7] -attr @rip ca_write_data[7] -pin u_cache1 write_data[7] -pin u_ctrl1 ca_write_data[7]
load net ca1_wr_data[8] -attr @rip ca_write_data[8] -pin u_cache1 write_data[8] -pin u_ctrl1 ca_write_data[8]
load net ca1_wr_data[9] -attr @rip ca_write_data[9] -pin u_cache1 write_data[9] -pin u_ctrl1 ca_write_data[9]
load net ca1_wr_en -pin u_cache1 write_en -pin u_ctrl1 ca_write_en
netloc ca1_wr_en 1 0 3 140 1250 NJ 1250 1170
load net ca1_wr_mesi[0] -attr @rip ca_write_mesi[0] -pin u_cache1 write_mesi[0] -pin u_ctrl1 ca_write_mesi[0]
load net ca1_wr_mesi[1] -attr @rip ca_write_mesi[1] -pin u_cache1 write_mesi[1] -pin u_ctrl1 ca_write_mesi[1]
load net ca1_wr_way -pin u_cache1 write_way -pin u_ctrl1 ca_write_way
netloc ca1_wr_way 1 0 3 180 1290 NJ 1290 1110
load net clk -port clk -pin u_arbiter clk -pin u_bus clk -pin u_cache0 clk -pin u_cache1 clk -pin u_ctrl0 clk -pin u_ctrl1 clk -pin u_memory clk
netloc clk 1 0 4 40 620 670 1190 1290 930 NJ
load net ctrl_addr_0[0] -attr @rip bus_addr[0] -pin u_bus ctrl_bus_addr_0[0] -pin u_ctrl0 bus_addr[0]
load net ctrl_addr_0[1] -attr @rip bus_addr[1] -pin u_bus ctrl_bus_addr_0[1] -pin u_ctrl0 bus_addr[1]
load net ctrl_addr_0[2] -attr @rip bus_addr[2] -pin u_bus ctrl_bus_addr_0[2] -pin u_ctrl0 bus_addr[2]
load net ctrl_addr_0[3] -attr @rip bus_addr[3] -pin u_bus ctrl_bus_addr_0[3] -pin u_ctrl0 bus_addr[3]
load net ctrl_addr_0[4] -attr @rip bus_addr[4] -pin u_bus ctrl_bus_addr_0[4] -pin u_ctrl0 bus_addr[4]
load net ctrl_addr_0[5] -attr @rip bus_addr[5] -pin u_bus ctrl_bus_addr_0[5] -pin u_ctrl0 bus_addr[5]
load net ctrl_addr_0[6] -attr @rip bus_addr[6] -pin u_bus ctrl_bus_addr_0[6] -pin u_ctrl0 bus_addr[6]
load net ctrl_addr_0[7] -attr @rip bus_addr[7] -pin u_bus ctrl_bus_addr_0[7] -pin u_ctrl0 bus_addr[7]
load net ctrl_addr_1[0] -attr @rip bus_addr[0] -pin u_bus ctrl_bus_addr_1[0] -pin u_ctrl1 bus_addr[0]
load net ctrl_addr_1[1] -attr @rip bus_addr[1] -pin u_bus ctrl_bus_addr_1[1] -pin u_ctrl1 bus_addr[1]
load net ctrl_addr_1[2] -attr @rip bus_addr[2] -pin u_bus ctrl_bus_addr_1[2] -pin u_ctrl1 bus_addr[2]
load net ctrl_addr_1[3] -attr @rip bus_addr[3] -pin u_bus ctrl_bus_addr_1[3] -pin u_ctrl1 bus_addr[3]
load net ctrl_addr_1[4] -attr @rip bus_addr[4] -pin u_bus ctrl_bus_addr_1[4] -pin u_ctrl1 bus_addr[4]
load net ctrl_addr_1[5] -attr @rip bus_addr[5] -pin u_bus ctrl_bus_addr_1[5] -pin u_ctrl1 bus_addr[5]
load net ctrl_addr_1[6] -attr @rip bus_addr[6] -pin u_bus ctrl_bus_addr_1[6] -pin u_ctrl1 bus_addr[6]
load net ctrl_addr_1[7] -attr @rip bus_addr[7] -pin u_bus ctrl_bus_addr_1[7] -pin u_ctrl1 bus_addr[7]
load net ctrl_bus_req[0] -attr @rip 0 -pin u_arbiter bus_req[0] -pin u_bus ctrl_bus_req[0] -pin u_ctrl0 bus_req
load net ctrl_bus_req[1] -attr @rip 1 -pin u_arbiter bus_req[1] -pin u_bus ctrl_bus_req[1] -pin u_ctrl1 bus_req
load net ctrl_cmd_0[0] -attr @rip bus_cmd[0] -pin u_bus ctrl_bus_cmd_0[0] -pin u_ctrl0 bus_cmd[0]
load net ctrl_cmd_0[1] -attr @rip bus_cmd[1] -pin u_bus ctrl_bus_cmd_0[1] -pin u_ctrl0 bus_cmd[1]
load net ctrl_cmd_0[2] -attr @rip bus_cmd[2] -pin u_bus ctrl_bus_cmd_0[2] -pin u_ctrl0 bus_cmd[2]
load net ctrl_cmd_1[0] -attr @rip bus_cmd[0] -pin u_bus ctrl_bus_cmd_1[0] -pin u_ctrl1 bus_cmd[0]
load net ctrl_cmd_1[1] -attr @rip bus_cmd[1] -pin u_bus ctrl_bus_cmd_1[1] -pin u_ctrl1 bus_cmd[1]
load net ctrl_cmd_1[2] -attr @rip bus_cmd[2] -pin u_bus ctrl_bus_cmd_1[2] -pin u_ctrl1 bus_cmd[2]
load net ctrl_dv_0 -pin u_bus ctrl_data_valid_0 -pin u_ctrl0 bus_data_valid
netloc ctrl_dv_0 1 2 2 NJ 290 1800
load net ctrl_dv_1 -pin u_bus ctrl_data_valid_1 -pin u_ctrl1 bus_data_valid
netloc ctrl_dv_1 1 2 2 NJ 830 1680
load net ctrl_sh_0 -pin u_bus ctrl_bus_shared_0 -pin u_ctrl0 bus_shared
netloc ctrl_sh_0 1 2 2 NJ 330 1840
load net ctrl_sh_1 -pin u_bus ctrl_bus_shared_1 -pin u_ctrl1 bus_shared
netloc ctrl_sh_1 1 2 2 NJ 870 1700
load net ctrl_wdata_0[0] -attr @rip bus_wdata[0] -pin u_bus ctrl_bus_wdata_0[0] -pin u_ctrl0 bus_wdata[0]
load net ctrl_wdata_0[10] -attr @rip bus_wdata[10] -pin u_bus ctrl_bus_wdata_0[10] -pin u_ctrl0 bus_wdata[10]
load net ctrl_wdata_0[11] -attr @rip bus_wdata[11] -pin u_bus ctrl_bus_wdata_0[11] -pin u_ctrl0 bus_wdata[11]
load net ctrl_wdata_0[12] -attr @rip bus_wdata[12] -pin u_bus ctrl_bus_wdata_0[12] -pin u_ctrl0 bus_wdata[12]
load net ctrl_wdata_0[13] -attr @rip bus_wdata[13] -pin u_bus ctrl_bus_wdata_0[13] -pin u_ctrl0 bus_wdata[13]
load net ctrl_wdata_0[14] -attr @rip bus_wdata[14] -pin u_bus ctrl_bus_wdata_0[14] -pin u_ctrl0 bus_wdata[14]
load net ctrl_wdata_0[15] -attr @rip bus_wdata[15] -pin u_bus ctrl_bus_wdata_0[15] -pin u_ctrl0 bus_wdata[15]
load net ctrl_wdata_0[16] -attr @rip bus_wdata[16] -pin u_bus ctrl_bus_wdata_0[16] -pin u_ctrl0 bus_wdata[16]
load net ctrl_wdata_0[17] -attr @rip bus_wdata[17] -pin u_bus ctrl_bus_wdata_0[17] -pin u_ctrl0 bus_wdata[17]
load net ctrl_wdata_0[18] -attr @rip bus_wdata[18] -pin u_bus ctrl_bus_wdata_0[18] -pin u_ctrl0 bus_wdata[18]
load net ctrl_wdata_0[19] -attr @rip bus_wdata[19] -pin u_bus ctrl_bus_wdata_0[19] -pin u_ctrl0 bus_wdata[19]
load net ctrl_wdata_0[1] -attr @rip bus_wdata[1] -pin u_bus ctrl_bus_wdata_0[1] -pin u_ctrl0 bus_wdata[1]
load net ctrl_wdata_0[20] -attr @rip bus_wdata[20] -pin u_bus ctrl_bus_wdata_0[20] -pin u_ctrl0 bus_wdata[20]
load net ctrl_wdata_0[21] -attr @rip bus_wdata[21] -pin u_bus ctrl_bus_wdata_0[21] -pin u_ctrl0 bus_wdata[21]
load net ctrl_wdata_0[22] -attr @rip bus_wdata[22] -pin u_bus ctrl_bus_wdata_0[22] -pin u_ctrl0 bus_wdata[22]
load net ctrl_wdata_0[23] -attr @rip bus_wdata[23] -pin u_bus ctrl_bus_wdata_0[23] -pin u_ctrl0 bus_wdata[23]
load net ctrl_wdata_0[24] -attr @rip bus_wdata[24] -pin u_bus ctrl_bus_wdata_0[24] -pin u_ctrl0 bus_wdata[24]
load net ctrl_wdata_0[25] -attr @rip bus_wdata[25] -pin u_bus ctrl_bus_wdata_0[25] -pin u_ctrl0 bus_wdata[25]
load net ctrl_wdata_0[26] -attr @rip bus_wdata[26] -pin u_bus ctrl_bus_wdata_0[26] -pin u_ctrl0 bus_wdata[26]
load net ctrl_wdata_0[27] -attr @rip bus_wdata[27] -pin u_bus ctrl_bus_wdata_0[27] -pin u_ctrl0 bus_wdata[27]
load net ctrl_wdata_0[28] -attr @rip bus_wdata[28] -pin u_bus ctrl_bus_wdata_0[28] -pin u_ctrl0 bus_wdata[28]
load net ctrl_wdata_0[29] -attr @rip bus_wdata[29] -pin u_bus ctrl_bus_wdata_0[29] -pin u_ctrl0 bus_wdata[29]
load net ctrl_wdata_0[2] -attr @rip bus_wdata[2] -pin u_bus ctrl_bus_wdata_0[2] -pin u_ctrl0 bus_wdata[2]
load net ctrl_wdata_0[30] -attr @rip bus_wdata[30] -pin u_bus ctrl_bus_wdata_0[30] -pin u_ctrl0 bus_wdata[30]
load net ctrl_wdata_0[31] -attr @rip bus_wdata[31] -pin u_bus ctrl_bus_wdata_0[31] -pin u_ctrl0 bus_wdata[31]
load net ctrl_wdata_0[32] -attr @rip bus_wdata[32] -pin u_bus ctrl_bus_wdata_0[32] -pin u_ctrl0 bus_wdata[32]
load net ctrl_wdata_0[33] -attr @rip bus_wdata[33] -pin u_bus ctrl_bus_wdata_0[33] -pin u_ctrl0 bus_wdata[33]
load net ctrl_wdata_0[34] -attr @rip bus_wdata[34] -pin u_bus ctrl_bus_wdata_0[34] -pin u_ctrl0 bus_wdata[34]
load net ctrl_wdata_0[35] -attr @rip bus_wdata[35] -pin u_bus ctrl_bus_wdata_0[35] -pin u_ctrl0 bus_wdata[35]
load net ctrl_wdata_0[36] -attr @rip bus_wdata[36] -pin u_bus ctrl_bus_wdata_0[36] -pin u_ctrl0 bus_wdata[36]
load net ctrl_wdata_0[37] -attr @rip bus_wdata[37] -pin u_bus ctrl_bus_wdata_0[37] -pin u_ctrl0 bus_wdata[37]
load net ctrl_wdata_0[38] -attr @rip bus_wdata[38] -pin u_bus ctrl_bus_wdata_0[38] -pin u_ctrl0 bus_wdata[38]
load net ctrl_wdata_0[39] -attr @rip bus_wdata[39] -pin u_bus ctrl_bus_wdata_0[39] -pin u_ctrl0 bus_wdata[39]
load net ctrl_wdata_0[3] -attr @rip bus_wdata[3] -pin u_bus ctrl_bus_wdata_0[3] -pin u_ctrl0 bus_wdata[3]
load net ctrl_wdata_0[40] -attr @rip bus_wdata[40] -pin u_bus ctrl_bus_wdata_0[40] -pin u_ctrl0 bus_wdata[40]
load net ctrl_wdata_0[41] -attr @rip bus_wdata[41] -pin u_bus ctrl_bus_wdata_0[41] -pin u_ctrl0 bus_wdata[41]
load net ctrl_wdata_0[42] -attr @rip bus_wdata[42] -pin u_bus ctrl_bus_wdata_0[42] -pin u_ctrl0 bus_wdata[42]
load net ctrl_wdata_0[43] -attr @rip bus_wdata[43] -pin u_bus ctrl_bus_wdata_0[43] -pin u_ctrl0 bus_wdata[43]
load net ctrl_wdata_0[44] -attr @rip bus_wdata[44] -pin u_bus ctrl_bus_wdata_0[44] -pin u_ctrl0 bus_wdata[44]
load net ctrl_wdata_0[45] -attr @rip bus_wdata[45] -pin u_bus ctrl_bus_wdata_0[45] -pin u_ctrl0 bus_wdata[45]
load net ctrl_wdata_0[46] -attr @rip bus_wdata[46] -pin u_bus ctrl_bus_wdata_0[46] -pin u_ctrl0 bus_wdata[46]
load net ctrl_wdata_0[47] -attr @rip bus_wdata[47] -pin u_bus ctrl_bus_wdata_0[47] -pin u_ctrl0 bus_wdata[47]
load net ctrl_wdata_0[48] -attr @rip bus_wdata[48] -pin u_bus ctrl_bus_wdata_0[48] -pin u_ctrl0 bus_wdata[48]
load net ctrl_wdata_0[49] -attr @rip bus_wdata[49] -pin u_bus ctrl_bus_wdata_0[49] -pin u_ctrl0 bus_wdata[49]
load net ctrl_wdata_0[4] -attr @rip bus_wdata[4] -pin u_bus ctrl_bus_wdata_0[4] -pin u_ctrl0 bus_wdata[4]
load net ctrl_wdata_0[50] -attr @rip bus_wdata[50] -pin u_bus ctrl_bus_wdata_0[50] -pin u_ctrl0 bus_wdata[50]
load net ctrl_wdata_0[51] -attr @rip bus_wdata[51] -pin u_bus ctrl_bus_wdata_0[51] -pin u_ctrl0 bus_wdata[51]
load net ctrl_wdata_0[52] -attr @rip bus_wdata[52] -pin u_bus ctrl_bus_wdata_0[52] -pin u_ctrl0 bus_wdata[52]
load net ctrl_wdata_0[53] -attr @rip bus_wdata[53] -pin u_bus ctrl_bus_wdata_0[53] -pin u_ctrl0 bus_wdata[53]
load net ctrl_wdata_0[54] -attr @rip bus_wdata[54] -pin u_bus ctrl_bus_wdata_0[54] -pin u_ctrl0 bus_wdata[54]
load net ctrl_wdata_0[55] -attr @rip bus_wdata[55] -pin u_bus ctrl_bus_wdata_0[55] -pin u_ctrl0 bus_wdata[55]
load net ctrl_wdata_0[56] -attr @rip bus_wdata[56] -pin u_bus ctrl_bus_wdata_0[56] -pin u_ctrl0 bus_wdata[56]
load net ctrl_wdata_0[57] -attr @rip bus_wdata[57] -pin u_bus ctrl_bus_wdata_0[57] -pin u_ctrl0 bus_wdata[57]
load net ctrl_wdata_0[58] -attr @rip bus_wdata[58] -pin u_bus ctrl_bus_wdata_0[58] -pin u_ctrl0 bus_wdata[58]
load net ctrl_wdata_0[59] -attr @rip bus_wdata[59] -pin u_bus ctrl_bus_wdata_0[59] -pin u_ctrl0 bus_wdata[59]
load net ctrl_wdata_0[5] -attr @rip bus_wdata[5] -pin u_bus ctrl_bus_wdata_0[5] -pin u_ctrl0 bus_wdata[5]
load net ctrl_wdata_0[60] -attr @rip bus_wdata[60] -pin u_bus ctrl_bus_wdata_0[60] -pin u_ctrl0 bus_wdata[60]
load net ctrl_wdata_0[61] -attr @rip bus_wdata[61] -pin u_bus ctrl_bus_wdata_0[61] -pin u_ctrl0 bus_wdata[61]
load net ctrl_wdata_0[62] -attr @rip bus_wdata[62] -pin u_bus ctrl_bus_wdata_0[62] -pin u_ctrl0 bus_wdata[62]
load net ctrl_wdata_0[63] -attr @rip bus_wdata[63] -pin u_bus ctrl_bus_wdata_0[63] -pin u_ctrl0 bus_wdata[63]
load net ctrl_wdata_0[6] -attr @rip bus_wdata[6] -pin u_bus ctrl_bus_wdata_0[6] -pin u_ctrl0 bus_wdata[6]
load net ctrl_wdata_0[7] -attr @rip bus_wdata[7] -pin u_bus ctrl_bus_wdata_0[7] -pin u_ctrl0 bus_wdata[7]
load net ctrl_wdata_0[8] -attr @rip bus_wdata[8] -pin u_bus ctrl_bus_wdata_0[8] -pin u_ctrl0 bus_wdata[8]
load net ctrl_wdata_0[9] -attr @rip bus_wdata[9] -pin u_bus ctrl_bus_wdata_0[9] -pin u_ctrl0 bus_wdata[9]
load net ctrl_wdata_1[0] -attr @rip bus_wdata[0] -pin u_bus ctrl_bus_wdata_1[0] -pin u_ctrl1 bus_wdata[0]
load net ctrl_wdata_1[10] -attr @rip bus_wdata[10] -pin u_bus ctrl_bus_wdata_1[10] -pin u_ctrl1 bus_wdata[10]
load net ctrl_wdata_1[11] -attr @rip bus_wdata[11] -pin u_bus ctrl_bus_wdata_1[11] -pin u_ctrl1 bus_wdata[11]
load net ctrl_wdata_1[12] -attr @rip bus_wdata[12] -pin u_bus ctrl_bus_wdata_1[12] -pin u_ctrl1 bus_wdata[12]
load net ctrl_wdata_1[13] -attr @rip bus_wdata[13] -pin u_bus ctrl_bus_wdata_1[13] -pin u_ctrl1 bus_wdata[13]
load net ctrl_wdata_1[14] -attr @rip bus_wdata[14] -pin u_bus ctrl_bus_wdata_1[14] -pin u_ctrl1 bus_wdata[14]
load net ctrl_wdata_1[15] -attr @rip bus_wdata[15] -pin u_bus ctrl_bus_wdata_1[15] -pin u_ctrl1 bus_wdata[15]
load net ctrl_wdata_1[16] -attr @rip bus_wdata[16] -pin u_bus ctrl_bus_wdata_1[16] -pin u_ctrl1 bus_wdata[16]
load net ctrl_wdata_1[17] -attr @rip bus_wdata[17] -pin u_bus ctrl_bus_wdata_1[17] -pin u_ctrl1 bus_wdata[17]
load net ctrl_wdata_1[18] -attr @rip bus_wdata[18] -pin u_bus ctrl_bus_wdata_1[18] -pin u_ctrl1 bus_wdata[18]
load net ctrl_wdata_1[19] -attr @rip bus_wdata[19] -pin u_bus ctrl_bus_wdata_1[19] -pin u_ctrl1 bus_wdata[19]
load net ctrl_wdata_1[1] -attr @rip bus_wdata[1] -pin u_bus ctrl_bus_wdata_1[1] -pin u_ctrl1 bus_wdata[1]
load net ctrl_wdata_1[20] -attr @rip bus_wdata[20] -pin u_bus ctrl_bus_wdata_1[20] -pin u_ctrl1 bus_wdata[20]
load net ctrl_wdata_1[21] -attr @rip bus_wdata[21] -pin u_bus ctrl_bus_wdata_1[21] -pin u_ctrl1 bus_wdata[21]
load net ctrl_wdata_1[22] -attr @rip bus_wdata[22] -pin u_bus ctrl_bus_wdata_1[22] -pin u_ctrl1 bus_wdata[22]
load net ctrl_wdata_1[23] -attr @rip bus_wdata[23] -pin u_bus ctrl_bus_wdata_1[23] -pin u_ctrl1 bus_wdata[23]
load net ctrl_wdata_1[24] -attr @rip bus_wdata[24] -pin u_bus ctrl_bus_wdata_1[24] -pin u_ctrl1 bus_wdata[24]
load net ctrl_wdata_1[25] -attr @rip bus_wdata[25] -pin u_bus ctrl_bus_wdata_1[25] -pin u_ctrl1 bus_wdata[25]
load net ctrl_wdata_1[26] -attr @rip bus_wdata[26] -pin u_bus ctrl_bus_wdata_1[26] -pin u_ctrl1 bus_wdata[26]
load net ctrl_wdata_1[27] -attr @rip bus_wdata[27] -pin u_bus ctrl_bus_wdata_1[27] -pin u_ctrl1 bus_wdata[27]
load net ctrl_wdata_1[28] -attr @rip bus_wdata[28] -pin u_bus ctrl_bus_wdata_1[28] -pin u_ctrl1 bus_wdata[28]
load net ctrl_wdata_1[29] -attr @rip bus_wdata[29] -pin u_bus ctrl_bus_wdata_1[29] -pin u_ctrl1 bus_wdata[29]
load net ctrl_wdata_1[2] -attr @rip bus_wdata[2] -pin u_bus ctrl_bus_wdata_1[2] -pin u_ctrl1 bus_wdata[2]
load net ctrl_wdata_1[30] -attr @rip bus_wdata[30] -pin u_bus ctrl_bus_wdata_1[30] -pin u_ctrl1 bus_wdata[30]
load net ctrl_wdata_1[31] -attr @rip bus_wdata[31] -pin u_bus ctrl_bus_wdata_1[31] -pin u_ctrl1 bus_wdata[31]
load net ctrl_wdata_1[32] -attr @rip bus_wdata[32] -pin u_bus ctrl_bus_wdata_1[32] -pin u_ctrl1 bus_wdata[32]
load net ctrl_wdata_1[33] -attr @rip bus_wdata[33] -pin u_bus ctrl_bus_wdata_1[33] -pin u_ctrl1 bus_wdata[33]
load net ctrl_wdata_1[34] -attr @rip bus_wdata[34] -pin u_bus ctrl_bus_wdata_1[34] -pin u_ctrl1 bus_wdata[34]
load net ctrl_wdata_1[35] -attr @rip bus_wdata[35] -pin u_bus ctrl_bus_wdata_1[35] -pin u_ctrl1 bus_wdata[35]
load net ctrl_wdata_1[36] -attr @rip bus_wdata[36] -pin u_bus ctrl_bus_wdata_1[36] -pin u_ctrl1 bus_wdata[36]
load net ctrl_wdata_1[37] -attr @rip bus_wdata[37] -pin u_bus ctrl_bus_wdata_1[37] -pin u_ctrl1 bus_wdata[37]
load net ctrl_wdata_1[38] -attr @rip bus_wdata[38] -pin u_bus ctrl_bus_wdata_1[38] -pin u_ctrl1 bus_wdata[38]
load net ctrl_wdata_1[39] -attr @rip bus_wdata[39] -pin u_bus ctrl_bus_wdata_1[39] -pin u_ctrl1 bus_wdata[39]
load net ctrl_wdata_1[3] -attr @rip bus_wdata[3] -pin u_bus ctrl_bus_wdata_1[3] -pin u_ctrl1 bus_wdata[3]
load net ctrl_wdata_1[40] -attr @rip bus_wdata[40] -pin u_bus ctrl_bus_wdata_1[40] -pin u_ctrl1 bus_wdata[40]
load net ctrl_wdata_1[41] -attr @rip bus_wdata[41] -pin u_bus ctrl_bus_wdata_1[41] -pin u_ctrl1 bus_wdata[41]
load net ctrl_wdata_1[42] -attr @rip bus_wdata[42] -pin u_bus ctrl_bus_wdata_1[42] -pin u_ctrl1 bus_wdata[42]
load net ctrl_wdata_1[43] -attr @rip bus_wdata[43] -pin u_bus ctrl_bus_wdata_1[43] -pin u_ctrl1 bus_wdata[43]
load net ctrl_wdata_1[44] -attr @rip bus_wdata[44] -pin u_bus ctrl_bus_wdata_1[44] -pin u_ctrl1 bus_wdata[44]
load net ctrl_wdata_1[45] -attr @rip bus_wdata[45] -pin u_bus ctrl_bus_wdata_1[45] -pin u_ctrl1 bus_wdata[45]
load net ctrl_wdata_1[46] -attr @rip bus_wdata[46] -pin u_bus ctrl_bus_wdata_1[46] -pin u_ctrl1 bus_wdata[46]
load net ctrl_wdata_1[47] -attr @rip bus_wdata[47] -pin u_bus ctrl_bus_wdata_1[47] -pin u_ctrl1 bus_wdata[47]
load net ctrl_wdata_1[48] -attr @rip bus_wdata[48] -pin u_bus ctrl_bus_wdata_1[48] -pin u_ctrl1 bus_wdata[48]
load net ctrl_wdata_1[49] -attr @rip bus_wdata[49] -pin u_bus ctrl_bus_wdata_1[49] -pin u_ctrl1 bus_wdata[49]
load net ctrl_wdata_1[4] -attr @rip bus_wdata[4] -pin u_bus ctrl_bus_wdata_1[4] -pin u_ctrl1 bus_wdata[4]
load net ctrl_wdata_1[50] -attr @rip bus_wdata[50] -pin u_bus ctrl_bus_wdata_1[50] -pin u_ctrl1 bus_wdata[50]
load net ctrl_wdata_1[51] -attr @rip bus_wdata[51] -pin u_bus ctrl_bus_wdata_1[51] -pin u_ctrl1 bus_wdata[51]
load net ctrl_wdata_1[52] -attr @rip bus_wdata[52] -pin u_bus ctrl_bus_wdata_1[52] -pin u_ctrl1 bus_wdata[52]
load net ctrl_wdata_1[53] -attr @rip bus_wdata[53] -pin u_bus ctrl_bus_wdata_1[53] -pin u_ctrl1 bus_wdata[53]
load net ctrl_wdata_1[54] -attr @rip bus_wdata[54] -pin u_bus ctrl_bus_wdata_1[54] -pin u_ctrl1 bus_wdata[54]
load net ctrl_wdata_1[55] -attr @rip bus_wdata[55] -pin u_bus ctrl_bus_wdata_1[55] -pin u_ctrl1 bus_wdata[55]
load net ctrl_wdata_1[56] -attr @rip bus_wdata[56] -pin u_bus ctrl_bus_wdata_1[56] -pin u_ctrl1 bus_wdata[56]
load net ctrl_wdata_1[57] -attr @rip bus_wdata[57] -pin u_bus ctrl_bus_wdata_1[57] -pin u_ctrl1 bus_wdata[57]
load net ctrl_wdata_1[58] -attr @rip bus_wdata[58] -pin u_bus ctrl_bus_wdata_1[58] -pin u_ctrl1 bus_wdata[58]
load net ctrl_wdata_1[59] -attr @rip bus_wdata[59] -pin u_bus ctrl_bus_wdata_1[59] -pin u_ctrl1 bus_wdata[59]
load net ctrl_wdata_1[5] -attr @rip bus_wdata[5] -pin u_bus ctrl_bus_wdata_1[5] -pin u_ctrl1 bus_wdata[5]
load net ctrl_wdata_1[60] -attr @rip bus_wdata[60] -pin u_bus ctrl_bus_wdata_1[60] -pin u_ctrl1 bus_wdata[60]
load net ctrl_wdata_1[61] -attr @rip bus_wdata[61] -pin u_bus ctrl_bus_wdata_1[61] -pin u_ctrl1 bus_wdata[61]
load net ctrl_wdata_1[62] -attr @rip bus_wdata[62] -pin u_bus ctrl_bus_wdata_1[62] -pin u_ctrl1 bus_wdata[62]
load net ctrl_wdata_1[63] -attr @rip bus_wdata[63] -pin u_bus ctrl_bus_wdata_1[63] -pin u_ctrl1 bus_wdata[63]
load net ctrl_wdata_1[6] -attr @rip bus_wdata[6] -pin u_bus ctrl_bus_wdata_1[6] -pin u_ctrl1 bus_wdata[6]
load net ctrl_wdata_1[7] -attr @rip bus_wdata[7] -pin u_bus ctrl_bus_wdata_1[7] -pin u_ctrl1 bus_wdata[7]
load net ctrl_wdata_1[8] -attr @rip bus_wdata[8] -pin u_bus ctrl_bus_wdata_1[8] -pin u_ctrl1 bus_wdata[8]
load net ctrl_wdata_1[9] -attr @rip bus_wdata[9] -pin u_bus ctrl_bus_wdata_1[9] -pin u_ctrl1 bus_wdata[9]
load net dbg_any_shared -port dbg_any_shared -pin u_bus any_shared -pin u_ctrl0 any_shared -pin u_ctrl1 any_shared
netloc dbg_any_shared 1 1 4 690 1330 1250J 1290 NJ 1290 2430
load net dbg_bus_grant[0] -attr @rip bus_grant[0] -port dbg_bus_grant[0] -pin u_arbiter bus_grant[0] -pin u_bus bus_grant[0] -pin u_ctrl0 bus_grant
load net dbg_bus_grant[1] -attr @rip bus_grant[1] -port dbg_bus_grant[1] -pin u_arbiter bus_grant[1] -pin u_bus bus_grant[1] -pin u_ctrl1 bus_grant
load net dbg_bus_phase[0] -attr @rip bus_phase[0] -port dbg_bus_phase[0] -pin u_arbiter bus_phase[0] -pin u_bus bus_phase[0]
load net dbg_bus_phase[1] -attr @rip bus_phase[1] -port dbg_bus_phase[1] -pin u_arbiter bus_phase[1] -pin u_bus bus_phase[1]
load net dbg_snoop_addr[0] -attr @rip snoop_addr[0] -port dbg_snoop_addr[0] -pin u_bus snoop_addr[0] -pin u_ctrl0 snoop_addr[0] -pin u_ctrl1 snoop_addr[0]
load net dbg_snoop_addr[1] -attr @rip snoop_addr[1] -port dbg_snoop_addr[1] -pin u_bus snoop_addr[1] -pin u_ctrl0 snoop_addr[1] -pin u_ctrl1 snoop_addr[1]
load net dbg_snoop_addr[2] -attr @rip snoop_addr[2] -port dbg_snoop_addr[2] -pin u_bus snoop_addr[2] -pin u_ctrl0 snoop_addr[2] -pin u_ctrl1 snoop_addr[2]
load net dbg_snoop_addr[3] -attr @rip snoop_addr[3] -port dbg_snoop_addr[3] -pin u_bus snoop_addr[3] -pin u_ctrl0 snoop_addr[3] -pin u_ctrl1 snoop_addr[3]
load net dbg_snoop_addr[4] -attr @rip snoop_addr[4] -port dbg_snoop_addr[4] -pin u_bus snoop_addr[4] -pin u_ctrl0 snoop_addr[4] -pin u_ctrl1 snoop_addr[4]
load net dbg_snoop_addr[5] -attr @rip snoop_addr[5] -port dbg_snoop_addr[5] -pin u_bus snoop_addr[5] -pin u_ctrl0 snoop_addr[5] -pin u_ctrl1 snoop_addr[5]
load net dbg_snoop_addr[6] -attr @rip snoop_addr[6] -port dbg_snoop_addr[6] -pin u_bus snoop_addr[6] -pin u_ctrl0 snoop_addr[6] -pin u_ctrl1 snoop_addr[6]
load net dbg_snoop_addr[7] -attr @rip snoop_addr[7] -port dbg_snoop_addr[7] -pin u_bus snoop_addr[7] -pin u_ctrl0 snoop_addr[7] -pin u_ctrl1 snoop_addr[7]
load net dbg_snoop_cmd[0] -attr @rip snoop_cmd[0] -port dbg_snoop_cmd[0] -pin u_bus snoop_cmd[0] -pin u_ctrl0 snoop_cmd[0] -pin u_ctrl1 snoop_cmd[0]
load net dbg_snoop_cmd[1] -attr @rip snoop_cmd[1] -port dbg_snoop_cmd[1] -pin u_bus snoop_cmd[1] -pin u_ctrl0 snoop_cmd[1] -pin u_ctrl1 snoop_cmd[1]
load net dbg_snoop_cmd[2] -attr @rip snoop_cmd[2] -port dbg_snoop_cmd[2] -pin u_bus snoop_cmd[2] -pin u_ctrl0 snoop_cmd[2] -pin u_ctrl1 snoop_cmd[2]
load net mem_addr[0] -attr @rip mem_addr[0] -pin u_bus mem_addr[0] -pin u_memory mem_addr[0]
load net mem_addr[1] -attr @rip mem_addr[1] -pin u_bus mem_addr[1] -pin u_memory mem_addr[1]
load net mem_addr[2] -attr @rip mem_addr[2] -pin u_bus mem_addr[2] -pin u_memory mem_addr[2]
load net mem_addr[3] -attr @rip mem_addr[3] -pin u_bus mem_addr[3] -pin u_memory mem_addr[3]
load net mem_addr[4] -attr @rip mem_addr[4] -pin u_bus mem_addr[4] -pin u_memory mem_addr[4]
load net mem_addr[5] -attr @rip mem_addr[5] -pin u_bus mem_addr[5] -pin u_memory mem_addr[5]
load net mem_addr[6] -attr @rip mem_addr[6] -pin u_bus mem_addr[6] -pin u_memory mem_addr[6]
load net mem_addr[7] -attr @rip mem_addr[7] -pin u_bus mem_addr[7] -pin u_memory mem_addr[7]
load net mem_cmd[0] -attr @rip mem_cmd[0] -pin u_bus mem_cmd[0] -pin u_memory mem_cmd[0]
load net mem_cmd[1] -attr @rip mem_cmd[1] -pin u_bus mem_cmd[1] -pin u_memory mem_cmd[1]
load net mem_cmd[2] -attr @rip mem_cmd[2] -pin u_bus mem_cmd[2] -pin u_memory mem_cmd[2]
load net mem_data[0] -attr @rip mem_data[0] -pin u_bus mem_data[0] -pin u_memory mem_data[0]
load net mem_data[10] -attr @rip mem_data[10] -pin u_bus mem_data[10] -pin u_memory mem_data[10]
load net mem_data[11] -attr @rip mem_data[11] -pin u_bus mem_data[11] -pin u_memory mem_data[11]
load net mem_data[12] -attr @rip mem_data[12] -pin u_bus mem_data[12] -pin u_memory mem_data[12]
load net mem_data[13] -attr @rip mem_data[13] -pin u_bus mem_data[13] -pin u_memory mem_data[13]
load net mem_data[14] -attr @rip mem_data[14] -pin u_bus mem_data[14] -pin u_memory mem_data[14]
load net mem_data[15] -attr @rip mem_data[15] -pin u_bus mem_data[15] -pin u_memory mem_data[15]
load net mem_data[16] -attr @rip mem_data[16] -pin u_bus mem_data[16] -pin u_memory mem_data[16]
load net mem_data[17] -attr @rip mem_data[17] -pin u_bus mem_data[17] -pin u_memory mem_data[17]
load net mem_data[18] -attr @rip mem_data[18] -pin u_bus mem_data[18] -pin u_memory mem_data[18]
load net mem_data[19] -attr @rip mem_data[19] -pin u_bus mem_data[19] -pin u_memory mem_data[19]
load net mem_data[1] -attr @rip mem_data[1] -pin u_bus mem_data[1] -pin u_memory mem_data[1]
load net mem_data[20] -attr @rip mem_data[20] -pin u_bus mem_data[20] -pin u_memory mem_data[20]
load net mem_data[21] -attr @rip mem_data[21] -pin u_bus mem_data[21] -pin u_memory mem_data[21]
load net mem_data[22] -attr @rip mem_data[22] -pin u_bus mem_data[22] -pin u_memory mem_data[22]
load net mem_data[23] -attr @rip mem_data[23] -pin u_bus mem_data[23] -pin u_memory mem_data[23]
load net mem_data[24] -attr @rip mem_data[24] -pin u_bus mem_data[24] -pin u_memory mem_data[24]
load net mem_data[25] -attr @rip mem_data[25] -pin u_bus mem_data[25] -pin u_memory mem_data[25]
load net mem_data[26] -attr @rip mem_data[26] -pin u_bus mem_data[26] -pin u_memory mem_data[26]
load net mem_data[27] -attr @rip mem_data[27] -pin u_bus mem_data[27] -pin u_memory mem_data[27]
load net mem_data[28] -attr @rip mem_data[28] -pin u_bus mem_data[28] -pin u_memory mem_data[28]
load net mem_data[29] -attr @rip mem_data[29] -pin u_bus mem_data[29] -pin u_memory mem_data[29]
load net mem_data[2] -attr @rip mem_data[2] -pin u_bus mem_data[2] -pin u_memory mem_data[2]
load net mem_data[30] -attr @rip mem_data[30] -pin u_bus mem_data[30] -pin u_memory mem_data[30]
load net mem_data[31] -attr @rip mem_data[31] -pin u_bus mem_data[31] -pin u_memory mem_data[31]
load net mem_data[32] -attr @rip mem_data[32] -pin u_bus mem_data[32] -pin u_memory mem_data[32]
load net mem_data[33] -attr @rip mem_data[33] -pin u_bus mem_data[33] -pin u_memory mem_data[33]
load net mem_data[34] -attr @rip mem_data[34] -pin u_bus mem_data[34] -pin u_memory mem_data[34]
load net mem_data[35] -attr @rip mem_data[35] -pin u_bus mem_data[35] -pin u_memory mem_data[35]
load net mem_data[36] -attr @rip mem_data[36] -pin u_bus mem_data[36] -pin u_memory mem_data[36]
load net mem_data[37] -attr @rip mem_data[37] -pin u_bus mem_data[37] -pin u_memory mem_data[37]
load net mem_data[38] -attr @rip mem_data[38] -pin u_bus mem_data[38] -pin u_memory mem_data[38]
load net mem_data[39] -attr @rip mem_data[39] -pin u_bus mem_data[39] -pin u_memory mem_data[39]
load net mem_data[3] -attr @rip mem_data[3] -pin u_bus mem_data[3] -pin u_memory mem_data[3]
load net mem_data[40] -attr @rip mem_data[40] -pin u_bus mem_data[40] -pin u_memory mem_data[40]
load net mem_data[41] -attr @rip mem_data[41] -pin u_bus mem_data[41] -pin u_memory mem_data[41]
load net mem_data[42] -attr @rip mem_data[42] -pin u_bus mem_data[42] -pin u_memory mem_data[42]
load net mem_data[43] -attr @rip mem_data[43] -pin u_bus mem_data[43] -pin u_memory mem_data[43]
load net mem_data[44] -attr @rip mem_data[44] -pin u_bus mem_data[44] -pin u_memory mem_data[44]
load net mem_data[45] -attr @rip mem_data[45] -pin u_bus mem_data[45] -pin u_memory mem_data[45]
load net mem_data[46] -attr @rip mem_data[46] -pin u_bus mem_data[46] -pin u_memory mem_data[46]
load net mem_data[47] -attr @rip mem_data[47] -pin u_bus mem_data[47] -pin u_memory mem_data[47]
load net mem_data[48] -attr @rip mem_data[48] -pin u_bus mem_data[48] -pin u_memory mem_data[48]
load net mem_data[49] -attr @rip mem_data[49] -pin u_bus mem_data[49] -pin u_memory mem_data[49]
load net mem_data[4] -attr @rip mem_data[4] -pin u_bus mem_data[4] -pin u_memory mem_data[4]
load net mem_data[50] -attr @rip mem_data[50] -pin u_bus mem_data[50] -pin u_memory mem_data[50]
load net mem_data[51] -attr @rip mem_data[51] -pin u_bus mem_data[51] -pin u_memory mem_data[51]
load net mem_data[52] -attr @rip mem_data[52] -pin u_bus mem_data[52] -pin u_memory mem_data[52]
load net mem_data[53] -attr @rip mem_data[53] -pin u_bus mem_data[53] -pin u_memory mem_data[53]
load net mem_data[54] -attr @rip mem_data[54] -pin u_bus mem_data[54] -pin u_memory mem_data[54]
load net mem_data[55] -attr @rip mem_data[55] -pin u_bus mem_data[55] -pin u_memory mem_data[55]
load net mem_data[56] -attr @rip mem_data[56] -pin u_bus mem_data[56] -pin u_memory mem_data[56]
load net mem_data[57] -attr @rip mem_data[57] -pin u_bus mem_data[57] -pin u_memory mem_data[57]
load net mem_data[58] -attr @rip mem_data[58] -pin u_bus mem_data[58] -pin u_memory mem_data[58]
load net mem_data[59] -attr @rip mem_data[59] -pin u_bus mem_data[59] -pin u_memory mem_data[59]
load net mem_data[5] -attr @rip mem_data[5] -pin u_bus mem_data[5] -pin u_memory mem_data[5]
load net mem_data[60] -attr @rip mem_data[60] -pin u_bus mem_data[60] -pin u_memory mem_data[60]
load net mem_data[61] -attr @rip mem_data[61] -pin u_bus mem_data[61] -pin u_memory mem_data[61]
load net mem_data[62] -attr @rip mem_data[62] -pin u_bus mem_data[62] -pin u_memory mem_data[62]
load net mem_data[63] -attr @rip mem_data[63] -pin u_bus mem_data[63] -pin u_memory mem_data[63]
load net mem_data[6] -attr @rip mem_data[6] -pin u_bus mem_data[6] -pin u_memory mem_data[6]
load net mem_data[7] -attr @rip mem_data[7] -pin u_bus mem_data[7] -pin u_memory mem_data[7]
load net mem_data[8] -attr @rip mem_data[8] -pin u_bus mem_data[8] -pin u_memory mem_data[8]
load net mem_data[9] -attr @rip mem_data[9] -pin u_bus mem_data[9] -pin u_memory mem_data[9]
load net mem_data_valid -pin u_bus mem_data_valid -pin u_memory mem_data_valid
netloc mem_data_valid 1 3 1 1900 1190n
load net mem_req -pin u_bus mem_req -pin u_memory mem_req
netloc mem_req 1 2 3 1270 1490 NJ 1490 2330
load net mem_wdata[0] -attr @rip mem_wdata[0] -pin u_bus mem_wdata[0] -pin u_memory mem_wdata[0]
load net mem_wdata[10] -attr @rip mem_wdata[10] -pin u_bus mem_wdata[10] -pin u_memory mem_wdata[10]
load net mem_wdata[11] -attr @rip mem_wdata[11] -pin u_bus mem_wdata[11] -pin u_memory mem_wdata[11]
load net mem_wdata[12] -attr @rip mem_wdata[12] -pin u_bus mem_wdata[12] -pin u_memory mem_wdata[12]
load net mem_wdata[13] -attr @rip mem_wdata[13] -pin u_bus mem_wdata[13] -pin u_memory mem_wdata[13]
load net mem_wdata[14] -attr @rip mem_wdata[14] -pin u_bus mem_wdata[14] -pin u_memory mem_wdata[14]
load net mem_wdata[15] -attr @rip mem_wdata[15] -pin u_bus mem_wdata[15] -pin u_memory mem_wdata[15]
load net mem_wdata[16] -attr @rip mem_wdata[16] -pin u_bus mem_wdata[16] -pin u_memory mem_wdata[16]
load net mem_wdata[17] -attr @rip mem_wdata[17] -pin u_bus mem_wdata[17] -pin u_memory mem_wdata[17]
load net mem_wdata[18] -attr @rip mem_wdata[18] -pin u_bus mem_wdata[18] -pin u_memory mem_wdata[18]
load net mem_wdata[19] -attr @rip mem_wdata[19] -pin u_bus mem_wdata[19] -pin u_memory mem_wdata[19]
load net mem_wdata[1] -attr @rip mem_wdata[1] -pin u_bus mem_wdata[1] -pin u_memory mem_wdata[1]
load net mem_wdata[20] -attr @rip mem_wdata[20] -pin u_bus mem_wdata[20] -pin u_memory mem_wdata[20]
load net mem_wdata[21] -attr @rip mem_wdata[21] -pin u_bus mem_wdata[21] -pin u_memory mem_wdata[21]
load net mem_wdata[22] -attr @rip mem_wdata[22] -pin u_bus mem_wdata[22] -pin u_memory mem_wdata[22]
load net mem_wdata[23] -attr @rip mem_wdata[23] -pin u_bus mem_wdata[23] -pin u_memory mem_wdata[23]
load net mem_wdata[24] -attr @rip mem_wdata[24] -pin u_bus mem_wdata[24] -pin u_memory mem_wdata[24]
load net mem_wdata[25] -attr @rip mem_wdata[25] -pin u_bus mem_wdata[25] -pin u_memory mem_wdata[25]
load net mem_wdata[26] -attr @rip mem_wdata[26] -pin u_bus mem_wdata[26] -pin u_memory mem_wdata[26]
load net mem_wdata[27] -attr @rip mem_wdata[27] -pin u_bus mem_wdata[27] -pin u_memory mem_wdata[27]
load net mem_wdata[28] -attr @rip mem_wdata[28] -pin u_bus mem_wdata[28] -pin u_memory mem_wdata[28]
load net mem_wdata[29] -attr @rip mem_wdata[29] -pin u_bus mem_wdata[29] -pin u_memory mem_wdata[29]
load net mem_wdata[2] -attr @rip mem_wdata[2] -pin u_bus mem_wdata[2] -pin u_memory mem_wdata[2]
load net mem_wdata[30] -attr @rip mem_wdata[30] -pin u_bus mem_wdata[30] -pin u_memory mem_wdata[30]
load net mem_wdata[31] -attr @rip mem_wdata[31] -pin u_bus mem_wdata[31] -pin u_memory mem_wdata[31]
load net mem_wdata[32] -attr @rip mem_wdata[32] -pin u_bus mem_wdata[32] -pin u_memory mem_wdata[32]
load net mem_wdata[33] -attr @rip mem_wdata[33] -pin u_bus mem_wdata[33] -pin u_memory mem_wdata[33]
load net mem_wdata[34] -attr @rip mem_wdata[34] -pin u_bus mem_wdata[34] -pin u_memory mem_wdata[34]
load net mem_wdata[35] -attr @rip mem_wdata[35] -pin u_bus mem_wdata[35] -pin u_memory mem_wdata[35]
load net mem_wdata[36] -attr @rip mem_wdata[36] -pin u_bus mem_wdata[36] -pin u_memory mem_wdata[36]
load net mem_wdata[37] -attr @rip mem_wdata[37] -pin u_bus mem_wdata[37] -pin u_memory mem_wdata[37]
load net mem_wdata[38] -attr @rip mem_wdata[38] -pin u_bus mem_wdata[38] -pin u_memory mem_wdata[38]
load net mem_wdata[39] -attr @rip mem_wdata[39] -pin u_bus mem_wdata[39] -pin u_memory mem_wdata[39]
load net mem_wdata[3] -attr @rip mem_wdata[3] -pin u_bus mem_wdata[3] -pin u_memory mem_wdata[3]
load net mem_wdata[40] -attr @rip mem_wdata[40] -pin u_bus mem_wdata[40] -pin u_memory mem_wdata[40]
load net mem_wdata[41] -attr @rip mem_wdata[41] -pin u_bus mem_wdata[41] -pin u_memory mem_wdata[41]
load net mem_wdata[42] -attr @rip mem_wdata[42] -pin u_bus mem_wdata[42] -pin u_memory mem_wdata[42]
load net mem_wdata[43] -attr @rip mem_wdata[43] -pin u_bus mem_wdata[43] -pin u_memory mem_wdata[43]
load net mem_wdata[44] -attr @rip mem_wdata[44] -pin u_bus mem_wdata[44] -pin u_memory mem_wdata[44]
load net mem_wdata[45] -attr @rip mem_wdata[45] -pin u_bus mem_wdata[45] -pin u_memory mem_wdata[45]
load net mem_wdata[46] -attr @rip mem_wdata[46] -pin u_bus mem_wdata[46] -pin u_memory mem_wdata[46]
load net mem_wdata[47] -attr @rip mem_wdata[47] -pin u_bus mem_wdata[47] -pin u_memory mem_wdata[47]
load net mem_wdata[48] -attr @rip mem_wdata[48] -pin u_bus mem_wdata[48] -pin u_memory mem_wdata[48]
load net mem_wdata[49] -attr @rip mem_wdata[49] -pin u_bus mem_wdata[49] -pin u_memory mem_wdata[49]
load net mem_wdata[4] -attr @rip mem_wdata[4] -pin u_bus mem_wdata[4] -pin u_memory mem_wdata[4]
load net mem_wdata[50] -attr @rip mem_wdata[50] -pin u_bus mem_wdata[50] -pin u_memory mem_wdata[50]
load net mem_wdata[51] -attr @rip mem_wdata[51] -pin u_bus mem_wdata[51] -pin u_memory mem_wdata[51]
load net mem_wdata[52] -attr @rip mem_wdata[52] -pin u_bus mem_wdata[52] -pin u_memory mem_wdata[52]
load net mem_wdata[53] -attr @rip mem_wdata[53] -pin u_bus mem_wdata[53] -pin u_memory mem_wdata[53]
load net mem_wdata[54] -attr @rip mem_wdata[54] -pin u_bus mem_wdata[54] -pin u_memory mem_wdata[54]
load net mem_wdata[55] -attr @rip mem_wdata[55] -pin u_bus mem_wdata[55] -pin u_memory mem_wdata[55]
load net mem_wdata[56] -attr @rip mem_wdata[56] -pin u_bus mem_wdata[56] -pin u_memory mem_wdata[56]
load net mem_wdata[57] -attr @rip mem_wdata[57] -pin u_bus mem_wdata[57] -pin u_memory mem_wdata[57]
load net mem_wdata[58] -attr @rip mem_wdata[58] -pin u_bus mem_wdata[58] -pin u_memory mem_wdata[58]
load net mem_wdata[59] -attr @rip mem_wdata[59] -pin u_bus mem_wdata[59] -pin u_memory mem_wdata[59]
load net mem_wdata[5] -attr @rip mem_wdata[5] -pin u_bus mem_wdata[5] -pin u_memory mem_wdata[5]
load net mem_wdata[60] -attr @rip mem_wdata[60] -pin u_bus mem_wdata[60] -pin u_memory mem_wdata[60]
load net mem_wdata[61] -attr @rip mem_wdata[61] -pin u_bus mem_wdata[61] -pin u_memory mem_wdata[61]
load net mem_wdata[62] -attr @rip mem_wdata[62] -pin u_bus mem_wdata[62] -pin u_memory mem_wdata[62]
load net mem_wdata[63] -attr @rip mem_wdata[63] -pin u_bus mem_wdata[63] -pin u_memory mem_wdata[63]
load net mem_wdata[6] -attr @rip mem_wdata[6] -pin u_bus mem_wdata[6] -pin u_memory mem_wdata[6]
load net mem_wdata[7] -attr @rip mem_wdata[7] -pin u_bus mem_wdata[7] -pin u_memory mem_wdata[7]
load net mem_wdata[8] -attr @rip mem_wdata[8] -pin u_bus mem_wdata[8] -pin u_memory mem_wdata[8]
load net mem_wdata[9] -attr @rip mem_wdata[9] -pin u_bus mem_wdata[9] -pin u_memory mem_wdata[9]
load net pr0_ack -port pr0_ack -pin u_ctrl0 pr_ack
netloc pr0_ack 1 2 3 1230J 520 NJ 520 NJ
load net pr0_addr[0] -attr @rip pr0_addr[0] -port pr0_addr[0] -pin u_ctrl0 pr_addr[0]
load net pr0_addr[1] -attr @rip pr0_addr[1] -port pr0_addr[1] -pin u_ctrl0 pr_addr[1]
load net pr0_addr[2] -attr @rip pr0_addr[2] -port pr0_addr[2] -pin u_ctrl0 pr_addr[2]
load net pr0_addr[3] -attr @rip pr0_addr[3] -port pr0_addr[3] -pin u_ctrl0 pr_addr[3]
load net pr0_addr[4] -attr @rip pr0_addr[4] -port pr0_addr[4] -pin u_ctrl0 pr_addr[4]
load net pr0_addr[5] -attr @rip pr0_addr[5] -port pr0_addr[5] -pin u_ctrl0 pr_addr[5]
load net pr0_addr[6] -attr @rip pr0_addr[6] -port pr0_addr[6] -pin u_ctrl0 pr_addr[6]
load net pr0_addr[7] -attr @rip pr0_addr[7] -port pr0_addr[7] -pin u_ctrl0 pr_addr[7]
load net pr0_rdata[0] -attr @rip pr_rdata[0] -port pr0_rdata[0] -pin u_ctrl0 pr_rdata[0]
load net pr0_rdata[1] -attr @rip pr_rdata[1] -port pr0_rdata[1] -pin u_ctrl0 pr_rdata[1]
load net pr0_rdata[2] -attr @rip pr_rdata[2] -port pr0_rdata[2] -pin u_ctrl0 pr_rdata[2]
load net pr0_rdata[3] -attr @rip pr_rdata[3] -port pr0_rdata[3] -pin u_ctrl0 pr_rdata[3]
load net pr0_rdata[4] -attr @rip pr_rdata[4] -port pr0_rdata[4] -pin u_ctrl0 pr_rdata[4]
load net pr0_rdata[5] -attr @rip pr_rdata[5] -port pr0_rdata[5] -pin u_ctrl0 pr_rdata[5]
load net pr0_rdata[6] -attr @rip pr_rdata[6] -port pr0_rdata[6] -pin u_ctrl0 pr_rdata[6]
load net pr0_rdata[7] -attr @rip pr_rdata[7] -port pr0_rdata[7] -pin u_ctrl0 pr_rdata[7]
load net pr0_req -port pr0_req -pin u_ctrl0 pr_req
netloc pr0_req 1 0 2 NJ 450 NJ
load net pr0_wdata[0] -attr @rip pr0_wdata[0] -port pr0_wdata[0] -pin u_ctrl0 pr_wdata[0]
load net pr0_wdata[1] -attr @rip pr0_wdata[1] -port pr0_wdata[1] -pin u_ctrl0 pr_wdata[1]
load net pr0_wdata[2] -attr @rip pr0_wdata[2] -port pr0_wdata[2] -pin u_ctrl0 pr_wdata[2]
load net pr0_wdata[3] -attr @rip pr0_wdata[3] -port pr0_wdata[3] -pin u_ctrl0 pr_wdata[3]
load net pr0_wdata[4] -attr @rip pr0_wdata[4] -port pr0_wdata[4] -pin u_ctrl0 pr_wdata[4]
load net pr0_wdata[5] -attr @rip pr0_wdata[5] -port pr0_wdata[5] -pin u_ctrl0 pr_wdata[5]
load net pr0_wdata[6] -attr @rip pr0_wdata[6] -port pr0_wdata[6] -pin u_ctrl0 pr_wdata[6]
load net pr0_wdata[7] -attr @rip pr0_wdata[7] -port pr0_wdata[7] -pin u_ctrl0 pr_wdata[7]
load net pr0_we -port pr0_we -pin u_ctrl0 pr_we
netloc pr0_we 1 0 2 NJ 510 570J
load net pr1_ack -port pr1_ack -pin u_ctrl1 pr_ack
netloc pr1_ack 1 2 3 1270J 1330 NJ 1330 NJ
load net pr1_addr[0] -attr @rip pr1_addr[0] -port pr1_addr[0] -pin u_ctrl1 pr_addr[0]
load net pr1_addr[1] -attr @rip pr1_addr[1] -port pr1_addr[1] -pin u_ctrl1 pr_addr[1]
load net pr1_addr[2] -attr @rip pr1_addr[2] -port pr1_addr[2] -pin u_ctrl1 pr_addr[2]
load net pr1_addr[3] -attr @rip pr1_addr[3] -port pr1_addr[3] -pin u_ctrl1 pr_addr[3]
load net pr1_addr[4] -attr @rip pr1_addr[4] -port pr1_addr[4] -pin u_ctrl1 pr_addr[4]
load net pr1_addr[5] -attr @rip pr1_addr[5] -port pr1_addr[5] -pin u_ctrl1 pr_addr[5]
load net pr1_addr[6] -attr @rip pr1_addr[6] -port pr1_addr[6] -pin u_ctrl1 pr_addr[6]
load net pr1_addr[7] -attr @rip pr1_addr[7] -port pr1_addr[7] -pin u_ctrl1 pr_addr[7]
load net pr1_rdata[0] -attr @rip pr_rdata[0] -port pr1_rdata[0] -pin u_ctrl1 pr_rdata[0]
load net pr1_rdata[1] -attr @rip pr_rdata[1] -port pr1_rdata[1] -pin u_ctrl1 pr_rdata[1]
load net pr1_rdata[2] -attr @rip pr_rdata[2] -port pr1_rdata[2] -pin u_ctrl1 pr_rdata[2]
load net pr1_rdata[3] -attr @rip pr_rdata[3] -port pr1_rdata[3] -pin u_ctrl1 pr_rdata[3]
load net pr1_rdata[4] -attr @rip pr_rdata[4] -port pr1_rdata[4] -pin u_ctrl1 pr_rdata[4]
load net pr1_rdata[5] -attr @rip pr_rdata[5] -port pr1_rdata[5] -pin u_ctrl1 pr_rdata[5]
load net pr1_rdata[6] -attr @rip pr_rdata[6] -port pr1_rdata[6] -pin u_ctrl1 pr_rdata[6]
load net pr1_rdata[7] -attr @rip pr_rdata[7] -port pr1_rdata[7] -pin u_ctrl1 pr_rdata[7]
load net pr1_req -port pr1_req -pin u_ctrl1 pr_req
netloc pr1_req 1 0 2 20J 1010 530J
load net pr1_wdata[0] -attr @rip pr1_wdata[0] -port pr1_wdata[0] -pin u_ctrl1 pr_wdata[0]
load net pr1_wdata[1] -attr @rip pr1_wdata[1] -port pr1_wdata[1] -pin u_ctrl1 pr_wdata[1]
load net pr1_wdata[2] -attr @rip pr1_wdata[2] -port pr1_wdata[2] -pin u_ctrl1 pr_wdata[2]
load net pr1_wdata[3] -attr @rip pr1_wdata[3] -port pr1_wdata[3] -pin u_ctrl1 pr_wdata[3]
load net pr1_wdata[4] -attr @rip pr1_wdata[4] -port pr1_wdata[4] -pin u_ctrl1 pr_wdata[4]
load net pr1_wdata[5] -attr @rip pr1_wdata[5] -port pr1_wdata[5] -pin u_ctrl1 pr_wdata[5]
load net pr1_wdata[6] -attr @rip pr1_wdata[6] -port pr1_wdata[6] -pin u_ctrl1 pr_wdata[6]
load net pr1_wdata[7] -attr @rip pr1_wdata[7] -port pr1_wdata[7] -pin u_ctrl1 pr_wdata[7]
load net pr1_we -port pr1_we -pin u_ctrl1 pr_we
netloc pr1_we 1 0 2 NJ 1060 570J
load net rst -port rst -pin u_arbiter rst -pin u_bus rst -pin u_cache0 rst -pin u_cache1 rst -pin u_ctrl0 rst -pin u_ctrl1 rst -pin u_memory rst
netloc rst 1 0 4 80 690 610 1310 1150 1450 1860
load net snoop_data[0] -attr @rip snoop_data[0] -pin u_bus snoop_data[0] -pin u_ctrl0 snoop_data[0] -pin u_ctrl1 snoop_data[0]
load net snoop_data[10] -attr @rip snoop_data[10] -pin u_bus snoop_data[10] -pin u_ctrl0 snoop_data[10] -pin u_ctrl1 snoop_data[10]
load net snoop_data[11] -attr @rip snoop_data[11] -pin u_bus snoop_data[11] -pin u_ctrl0 snoop_data[11] -pin u_ctrl1 snoop_data[11]
load net snoop_data[12] -attr @rip snoop_data[12] -pin u_bus snoop_data[12] -pin u_ctrl0 snoop_data[12] -pin u_ctrl1 snoop_data[12]
load net snoop_data[13] -attr @rip snoop_data[13] -pin u_bus snoop_data[13] -pin u_ctrl0 snoop_data[13] -pin u_ctrl1 snoop_data[13]
load net snoop_data[14] -attr @rip snoop_data[14] -pin u_bus snoop_data[14] -pin u_ctrl0 snoop_data[14] -pin u_ctrl1 snoop_data[14]
load net snoop_data[15] -attr @rip snoop_data[15] -pin u_bus snoop_data[15] -pin u_ctrl0 snoop_data[15] -pin u_ctrl1 snoop_data[15]
load net snoop_data[16] -attr @rip snoop_data[16] -pin u_bus snoop_data[16] -pin u_ctrl0 snoop_data[16] -pin u_ctrl1 snoop_data[16]
load net snoop_data[17] -attr @rip snoop_data[17] -pin u_bus snoop_data[17] -pin u_ctrl0 snoop_data[17] -pin u_ctrl1 snoop_data[17]
load net snoop_data[18] -attr @rip snoop_data[18] -pin u_bus snoop_data[18] -pin u_ctrl0 snoop_data[18] -pin u_ctrl1 snoop_data[18]
load net snoop_data[19] -attr @rip snoop_data[19] -pin u_bus snoop_data[19] -pin u_ctrl0 snoop_data[19] -pin u_ctrl1 snoop_data[19]
load net snoop_data[1] -attr @rip snoop_data[1] -pin u_bus snoop_data[1] -pin u_ctrl0 snoop_data[1] -pin u_ctrl1 snoop_data[1]
load net snoop_data[20] -attr @rip snoop_data[20] -pin u_bus snoop_data[20] -pin u_ctrl0 snoop_data[20] -pin u_ctrl1 snoop_data[20]
load net snoop_data[21] -attr @rip snoop_data[21] -pin u_bus snoop_data[21] -pin u_ctrl0 snoop_data[21] -pin u_ctrl1 snoop_data[21]
load net snoop_data[22] -attr @rip snoop_data[22] -pin u_bus snoop_data[22] -pin u_ctrl0 snoop_data[22] -pin u_ctrl1 snoop_data[22]
load net snoop_data[23] -attr @rip snoop_data[23] -pin u_bus snoop_data[23] -pin u_ctrl0 snoop_data[23] -pin u_ctrl1 snoop_data[23]
load net snoop_data[24] -attr @rip snoop_data[24] -pin u_bus snoop_data[24] -pin u_ctrl0 snoop_data[24] -pin u_ctrl1 snoop_data[24]
load net snoop_data[25] -attr @rip snoop_data[25] -pin u_bus snoop_data[25] -pin u_ctrl0 snoop_data[25] -pin u_ctrl1 snoop_data[25]
load net snoop_data[26] -attr @rip snoop_data[26] -pin u_bus snoop_data[26] -pin u_ctrl0 snoop_data[26] -pin u_ctrl1 snoop_data[26]
load net snoop_data[27] -attr @rip snoop_data[27] -pin u_bus snoop_data[27] -pin u_ctrl0 snoop_data[27] -pin u_ctrl1 snoop_data[27]
load net snoop_data[28] -attr @rip snoop_data[28] -pin u_bus snoop_data[28] -pin u_ctrl0 snoop_data[28] -pin u_ctrl1 snoop_data[28]
load net snoop_data[29] -attr @rip snoop_data[29] -pin u_bus snoop_data[29] -pin u_ctrl0 snoop_data[29] -pin u_ctrl1 snoop_data[29]
load net snoop_data[2] -attr @rip snoop_data[2] -pin u_bus snoop_data[2] -pin u_ctrl0 snoop_data[2] -pin u_ctrl1 snoop_data[2]
load net snoop_data[30] -attr @rip snoop_data[30] -pin u_bus snoop_data[30] -pin u_ctrl0 snoop_data[30] -pin u_ctrl1 snoop_data[30]
load net snoop_data[31] -attr @rip snoop_data[31] -pin u_bus snoop_data[31] -pin u_ctrl0 snoop_data[31] -pin u_ctrl1 snoop_data[31]
load net snoop_data[32] -attr @rip snoop_data[32] -pin u_bus snoop_data[32] -pin u_ctrl0 snoop_data[32] -pin u_ctrl1 snoop_data[32]
load net snoop_data[33] -attr @rip snoop_data[33] -pin u_bus snoop_data[33] -pin u_ctrl0 snoop_data[33] -pin u_ctrl1 snoop_data[33]
load net snoop_data[34] -attr @rip snoop_data[34] -pin u_bus snoop_data[34] -pin u_ctrl0 snoop_data[34] -pin u_ctrl1 snoop_data[34]
load net snoop_data[35] -attr @rip snoop_data[35] -pin u_bus snoop_data[35] -pin u_ctrl0 snoop_data[35] -pin u_ctrl1 snoop_data[35]
load net snoop_data[36] -attr @rip snoop_data[36] -pin u_bus snoop_data[36] -pin u_ctrl0 snoop_data[36] -pin u_ctrl1 snoop_data[36]
load net snoop_data[37] -attr @rip snoop_data[37] -pin u_bus snoop_data[37] -pin u_ctrl0 snoop_data[37] -pin u_ctrl1 snoop_data[37]
load net snoop_data[38] -attr @rip snoop_data[38] -pin u_bus snoop_data[38] -pin u_ctrl0 snoop_data[38] -pin u_ctrl1 snoop_data[38]
load net snoop_data[39] -attr @rip snoop_data[39] -pin u_bus snoop_data[39] -pin u_ctrl0 snoop_data[39] -pin u_ctrl1 snoop_data[39]
load net snoop_data[3] -attr @rip snoop_data[3] -pin u_bus snoop_data[3] -pin u_ctrl0 snoop_data[3] -pin u_ctrl1 snoop_data[3]
load net snoop_data[40] -attr @rip snoop_data[40] -pin u_bus snoop_data[40] -pin u_ctrl0 snoop_data[40] -pin u_ctrl1 snoop_data[40]
load net snoop_data[41] -attr @rip snoop_data[41] -pin u_bus snoop_data[41] -pin u_ctrl0 snoop_data[41] -pin u_ctrl1 snoop_data[41]
load net snoop_data[42] -attr @rip snoop_data[42] -pin u_bus snoop_data[42] -pin u_ctrl0 snoop_data[42] -pin u_ctrl1 snoop_data[42]
load net snoop_data[43] -attr @rip snoop_data[43] -pin u_bus snoop_data[43] -pin u_ctrl0 snoop_data[43] -pin u_ctrl1 snoop_data[43]
load net snoop_data[44] -attr @rip snoop_data[44] -pin u_bus snoop_data[44] -pin u_ctrl0 snoop_data[44] -pin u_ctrl1 snoop_data[44]
load net snoop_data[45] -attr @rip snoop_data[45] -pin u_bus snoop_data[45] -pin u_ctrl0 snoop_data[45] -pin u_ctrl1 snoop_data[45]
load net snoop_data[46] -attr @rip snoop_data[46] -pin u_bus snoop_data[46] -pin u_ctrl0 snoop_data[46] -pin u_ctrl1 snoop_data[46]
load net snoop_data[47] -attr @rip snoop_data[47] -pin u_bus snoop_data[47] -pin u_ctrl0 snoop_data[47] -pin u_ctrl1 snoop_data[47]
load net snoop_data[48] -attr @rip snoop_data[48] -pin u_bus snoop_data[48] -pin u_ctrl0 snoop_data[48] -pin u_ctrl1 snoop_data[48]
load net snoop_data[49] -attr @rip snoop_data[49] -pin u_bus snoop_data[49] -pin u_ctrl0 snoop_data[49] -pin u_ctrl1 snoop_data[49]
load net snoop_data[4] -attr @rip snoop_data[4] -pin u_bus snoop_data[4] -pin u_ctrl0 snoop_data[4] -pin u_ctrl1 snoop_data[4]
load net snoop_data[50] -attr @rip snoop_data[50] -pin u_bus snoop_data[50] -pin u_ctrl0 snoop_data[50] -pin u_ctrl1 snoop_data[50]
load net snoop_data[51] -attr @rip snoop_data[51] -pin u_bus snoop_data[51] -pin u_ctrl0 snoop_data[51] -pin u_ctrl1 snoop_data[51]
load net snoop_data[52] -attr @rip snoop_data[52] -pin u_bus snoop_data[52] -pin u_ctrl0 snoop_data[52] -pin u_ctrl1 snoop_data[52]
load net snoop_data[53] -attr @rip snoop_data[53] -pin u_bus snoop_data[53] -pin u_ctrl0 snoop_data[53] -pin u_ctrl1 snoop_data[53]
load net snoop_data[54] -attr @rip snoop_data[54] -pin u_bus snoop_data[54] -pin u_ctrl0 snoop_data[54] -pin u_ctrl1 snoop_data[54]
load net snoop_data[55] -attr @rip snoop_data[55] -pin u_bus snoop_data[55] -pin u_ctrl0 snoop_data[55] -pin u_ctrl1 snoop_data[55]
load net snoop_data[56] -attr @rip snoop_data[56] -pin u_bus snoop_data[56] -pin u_ctrl0 snoop_data[56] -pin u_ctrl1 snoop_data[56]
load net snoop_data[57] -attr @rip snoop_data[57] -pin u_bus snoop_data[57] -pin u_ctrl0 snoop_data[57] -pin u_ctrl1 snoop_data[57]
load net snoop_data[58] -attr @rip snoop_data[58] -pin u_bus snoop_data[58] -pin u_ctrl0 snoop_data[58] -pin u_ctrl1 snoop_data[58]
load net snoop_data[59] -attr @rip snoop_data[59] -pin u_bus snoop_data[59] -pin u_ctrl0 snoop_data[59] -pin u_ctrl1 snoop_data[59]
load net snoop_data[5] -attr @rip snoop_data[5] -pin u_bus snoop_data[5] -pin u_ctrl0 snoop_data[5] -pin u_ctrl1 snoop_data[5]
load net snoop_data[60] -attr @rip snoop_data[60] -pin u_bus snoop_data[60] -pin u_ctrl0 snoop_data[60] -pin u_ctrl1 snoop_data[60]
load net snoop_data[61] -attr @rip snoop_data[61] -pin u_bus snoop_data[61] -pin u_ctrl0 snoop_data[61] -pin u_ctrl1 snoop_data[61]
load net snoop_data[62] -attr @rip snoop_data[62] -pin u_bus snoop_data[62] -pin u_ctrl0 snoop_data[62] -pin u_ctrl1 snoop_data[62]
load net snoop_data[63] -attr @rip snoop_data[63] -pin u_bus snoop_data[63] -pin u_ctrl0 snoop_data[63] -pin u_ctrl1 snoop_data[63]
load net snoop_data[6] -attr @rip snoop_data[6] -pin u_bus snoop_data[6] -pin u_ctrl0 snoop_data[6] -pin u_ctrl1 snoop_data[6]
load net snoop_data[7] -attr @rip snoop_data[7] -pin u_bus snoop_data[7] -pin u_ctrl0 snoop_data[7] -pin u_ctrl1 snoop_data[7]
load net snoop_data[8] -attr @rip snoop_data[8] -pin u_bus snoop_data[8] -pin u_ctrl0 snoop_data[8] -pin u_ctrl1 snoop_data[8]
load net snoop_data[9] -attr @rip snoop_data[9] -pin u_bus snoop_data[9] -pin u_ctrl0 snoop_data[9] -pin u_ctrl1 snoop_data[9]
load net snoop_data_ready -pin u_bus snoop_data_ready -pin u_ctrl0 snoop_data_ready -pin u_ctrl1 snoop_data_ready
netloc snoop_data_ready 1 1 4 650 1710 NJ 1710 NJ 1710 2270
load net snoop_valid -pin u_bus snoop_valid -pin u_ctrl0 snoop_valid -pin u_ctrl1 snoop_valid
netloc snoop_valid 1 1 4 710 1430 NJ 1430 NJ 1430 2250
load netBundle @pr0_addr 8 pr0_addr[7] pr0_addr[6] pr0_addr[5] pr0_addr[4] pr0_addr[3] pr0_addr[2] pr0_addr[1] pr0_addr[0] -autobundled
netbloc @pr0_addr 1 0 2 20J 430 NJ
load netBundle @pr0_wdata 8 pr0_wdata[7] pr0_wdata[6] pr0_wdata[5] pr0_wdata[4] pr0_wdata[3] pr0_wdata[2] pr0_wdata[1] pr0_wdata[0] -autobundled
netbloc @pr0_wdata 1 0 2 NJ 480 510J
load netBundle @pr1_addr 8 pr1_addr[7] pr1_addr[6] pr1_addr[5] pr1_addr[4] pr1_addr[3] pr1_addr[2] pr1_addr[1] pr1_addr[0] -autobundled
netbloc @pr1_addr 1 0 2 40J 990 510J
load netBundle @pr1_wdata 8 pr1_wdata[7] pr1_wdata[6] pr1_wdata[5] pr1_wdata[4] pr1_wdata[3] pr1_wdata[2] pr1_wdata[1] pr1_wdata[0] -autobundled
netbloc @pr1_wdata 1 0 2 NJ 1030 550J
load netBundle @dbg_bus_grant 2 dbg_bus_grant[1] dbg_bus_grant[0] -autobundled
netbloc @dbg_bus_grant 1 1 4 730 1390 NJ 1390 1760 1250 NJ
load netBundle @dbg_bus_phase 2 dbg_bus_phase[1] dbg_bus_phase[0] -autobundled
netbloc @dbg_bus_phase 1 2 3 1350 910 1740J 850 2450
load netBundle @dbg_snoop_addr 8 dbg_snoop_addr[7] dbg_snoop_addr[6] dbg_snoop_addr[5] dbg_snoop_addr[4] dbg_snoop_addr[3] dbg_snoop_addr[2] dbg_snoop_addr[1] dbg_snoop_addr[0] -autobundled
netbloc @dbg_snoop_addr 1 1 4 750 1350 1170J 1310 NJ 1310 2410
load netBundle @dbg_snoop_cmd 3 dbg_snoop_cmd[2] dbg_snoop_cmd[1] dbg_snoop_cmd[0] -autobundled
netbloc @dbg_snoop_cmd 1 1 4 770 1370 1190J 1350 NJ 1350 2390
load netBundle @pr0_rdata 8 pr0_rdata[7] pr0_rdata[6] pr0_rdata[5] pr0_rdata[4] pr0_rdata[3] pr0_rdata[2] pr0_rdata[1] pr0_rdata[0] -autobundled
netbloc @pr0_rdata 1 2 3 NJ 550 NJ 550 NJ
load netBundle @pr1_rdata 8 pr1_rdata[7] pr1_rdata[6] pr1_rdata[5] pr1_rdata[4] pr1_rdata[3] pr1_rdata[2] pr1_rdata[1] pr1_rdata[0] -autobundled
netbloc @pr1_rdata 1 2 3 1230J 1370 NJ 1370 NJ
load netBundle @mem_addr 8 mem_addr[7] mem_addr[6] mem_addr[5] mem_addr[4] mem_addr[3] mem_addr[2] mem_addr[1] mem_addr[0] -autobundled
netbloc @mem_addr 1 2 3 1350 1270 NJ 1270 2370
load netBundle @mem_cmd 3 mem_cmd[2] mem_cmd[1] mem_cmd[0] -autobundled
netbloc @mem_cmd 1 2 3 1210 1470 NJ 1470 2350
load netBundle @mem_wdata 64 mem_wdata[63] mem_wdata[62] mem_wdata[61] mem_wdata[60] mem_wdata[59] mem_wdata[58] mem_wdata[57] mem_wdata[56] mem_wdata[55] mem_wdata[54] mem_wdata[53] mem_wdata[52] mem_wdata[51] mem_wdata[50] mem_wdata[49] mem_wdata[48] mem_wdata[47] mem_wdata[46] mem_wdata[45] mem_wdata[44] mem_wdata[43] mem_wdata[42] mem_wdata[41] mem_wdata[40] mem_wdata[39] mem_wdata[38] mem_wdata[37] mem_wdata[36] mem_wdata[35] mem_wdata[34] mem_wdata[33] mem_wdata[32] mem_wdata[31] mem_wdata[30] mem_wdata[29] mem_wdata[28] mem_wdata[27] mem_wdata[26] mem_wdata[25] mem_wdata[24] mem_wdata[23] mem_wdata[22] mem_wdata[21] mem_wdata[20] mem_wdata[19] mem_wdata[18] mem_wdata[17] mem_wdata[16] mem_wdata[15] mem_wdata[14] mem_wdata[13] mem_wdata[12] mem_wdata[11] mem_wdata[10] mem_wdata[9] mem_wdata[8] mem_wdata[7] mem_wdata[6] mem_wdata[5] mem_wdata[4] mem_wdata[3] mem_wdata[2] mem_wdata[1] mem_wdata[0] -autobundled
netbloc @mem_wdata 1 2 3 1330 1510 NJ 1510 2310
load netBundle @snoop_data 64 snoop_data[63] snoop_data[62] snoop_data[61] snoop_data[60] snoop_data[59] snoop_data[58] snoop_data[57] snoop_data[56] snoop_data[55] snoop_data[54] snoop_data[53] snoop_data[52] snoop_data[51] snoop_data[50] snoop_data[49] snoop_data[48] snoop_data[47] snoop_data[46] snoop_data[45] snoop_data[44] snoop_data[43] snoop_data[42] snoop_data[41] snoop_data[40] snoop_data[39] snoop_data[38] snoop_data[37] snoop_data[36] snoop_data[35] snoop_data[34] snoop_data[33] snoop_data[32] snoop_data[31] snoop_data[30] snoop_data[29] snoop_data[28] snoop_data[27] snoop_data[26] snoop_data[25] snoop_data[24] snoop_data[23] snoop_data[22] snoop_data[21] snoop_data[20] snoop_data[19] snoop_data[18] snoop_data[17] snoop_data[16] snoop_data[15] snoop_data[14] snoop_data[13] snoop_data[12] snoop_data[11] snoop_data[10] snoop_data[9] snoop_data[8] snoop_data[7] snoop_data[6] snoop_data[5] snoop_data[4] snoop_data[3] snoop_data[2] snoop_data[1] snoop_data[0] -autobundled
netbloc @snoop_data 1 1 4 590 1410 NJ 1410 NJ 1410 2290
load netBundle @ca0_ev_addr 8 ca0_ev_addr[7] ca0_ev_addr[6] ca0_ev_addr[5] ca0_ev_addr[4] ca0_ev_addr[3] ca0_ev_addr[2] ca0_ev_addr[1] ca0_ev_addr[0] -autobundled
netbloc @ca0_ev_addr 1 1 1 670 210n
load netBundle @ca0_ev_data 64 ca0_ev_data[63] ca0_ev_data[62] ca0_ev_data[61] ca0_ev_data[60] ca0_ev_data[59] ca0_ev_data[58] ca0_ev_data[57] ca0_ev_data[56] ca0_ev_data[55] ca0_ev_data[54] ca0_ev_data[53] ca0_ev_data[52] ca0_ev_data[51] ca0_ev_data[50] ca0_ev_data[49] ca0_ev_data[48] ca0_ev_data[47] ca0_ev_data[46] ca0_ev_data[45] ca0_ev_data[44] ca0_ev_data[43] ca0_ev_data[42] ca0_ev_data[41] ca0_ev_data[40] ca0_ev_data[39] ca0_ev_data[38] ca0_ev_data[37] ca0_ev_data[36] ca0_ev_data[35] ca0_ev_data[34] ca0_ev_data[33] ca0_ev_data[32] ca0_ev_data[31] ca0_ev_data[30] ca0_ev_data[29] ca0_ev_data[28] ca0_ev_data[27] ca0_ev_data[26] ca0_ev_data[25] ca0_ev_data[24] ca0_ev_data[23] ca0_ev_data[22] ca0_ev_data[21] ca0_ev_data[20] ca0_ev_data[19] ca0_ev_data[18] ca0_ev_data[17] ca0_ev_data[16] ca0_ev_data[15] ca0_ev_data[14] ca0_ev_data[13] ca0_ev_data[12] ca0_ev_data[11] ca0_ev_data[10] ca0_ev_data[9] ca0_ev_data[8] ca0_ev_data[7] ca0_ev_data[6] ca0_ev_data[5] ca0_ev_data[4] ca0_ev_data[3] ca0_ev_data[2] ca0_ev_data[1] ca0_ev_data[0] -autobundled
netbloc @ca0_ev_data 1 1 1 650 230n
load netBundle @ca0_ev_mesi 2 ca0_ev_mesi[1] ca0_ev_mesi[0] -autobundled
netbloc @ca0_ev_mesi 1 1 1 630 250n
load netBundle @ca0_hit_data 64 ca0_hit_data[63] ca0_hit_data[62] ca0_hit_data[61] ca0_hit_data[60] ca0_hit_data[59] ca0_hit_data[58] ca0_hit_data[57] ca0_hit_data[56] ca0_hit_data[55] ca0_hit_data[54] ca0_hit_data[53] ca0_hit_data[52] ca0_hit_data[51] ca0_hit_data[50] ca0_hit_data[49] ca0_hit_data[48] ca0_hit_data[47] ca0_hit_data[46] ca0_hit_data[45] ca0_hit_data[44] ca0_hit_data[43] ca0_hit_data[42] ca0_hit_data[41] ca0_hit_data[40] ca0_hit_data[39] ca0_hit_data[38] ca0_hit_data[37] ca0_hit_data[36] ca0_hit_data[35] ca0_hit_data[34] ca0_hit_data[33] ca0_hit_data[32] ca0_hit_data[31] ca0_hit_data[30] ca0_hit_data[29] ca0_hit_data[28] ca0_hit_data[27] ca0_hit_data[26] ca0_hit_data[25] ca0_hit_data[24] ca0_hit_data[23] ca0_hit_data[22] ca0_hit_data[21] ca0_hit_data[20] ca0_hit_data[19] ca0_hit_data[18] ca0_hit_data[17] ca0_hit_data[16] ca0_hit_data[15] ca0_hit_data[14] ca0_hit_data[13] ca0_hit_data[12] ca0_hit_data[11] ca0_hit_data[10] ca0_hit_data[9] ca0_hit_data[8] ca0_hit_data[7] ca0_hit_data[6] ca0_hit_data[5] ca0_hit_data[4] ca0_hit_data[3] ca0_hit_data[2] ca0_hit_data[1] ca0_hit_data[0] -autobundled
netbloc @ca0_hit_data 1 1 1 590 290n
load netBundle @ca0_hit_mesi 2 ca0_hit_mesi[1] ca0_hit_mesi[0] -autobundled
netbloc @ca0_hit_mesi 1 1 1 570 310n
load netBundle @ca1_ev_addr 8 ca1_ev_addr[7] ca1_ev_addr[6] ca1_ev_addr[5] ca1_ev_addr[4] ca1_ev_addr[3] ca1_ev_addr[2] ca1_ev_addr[1] ca1_ev_addr[0] -autobundled
netbloc @ca1_ev_addr 1 1 1 N 790
load netBundle @ca1_ev_data 64 ca1_ev_data[63] ca1_ev_data[62] ca1_ev_data[61] ca1_ev_data[60] ca1_ev_data[59] ca1_ev_data[58] ca1_ev_data[57] ca1_ev_data[56] ca1_ev_data[55] ca1_ev_data[54] ca1_ev_data[53] ca1_ev_data[52] ca1_ev_data[51] ca1_ev_data[50] ca1_ev_data[49] ca1_ev_data[48] ca1_ev_data[47] ca1_ev_data[46] ca1_ev_data[45] ca1_ev_data[44] ca1_ev_data[43] ca1_ev_data[42] ca1_ev_data[41] ca1_ev_data[40] ca1_ev_data[39] ca1_ev_data[38] ca1_ev_data[37] ca1_ev_data[36] ca1_ev_data[35] ca1_ev_data[34] ca1_ev_data[33] ca1_ev_data[32] ca1_ev_data[31] ca1_ev_data[30] ca1_ev_data[29] ca1_ev_data[28] ca1_ev_data[27] ca1_ev_data[26] ca1_ev_data[25] ca1_ev_data[24] ca1_ev_data[23] ca1_ev_data[22] ca1_ev_data[21] ca1_ev_data[20] ca1_ev_data[19] ca1_ev_data[18] ca1_ev_data[17] ca1_ev_data[16] ca1_ev_data[15] ca1_ev_data[14] ca1_ev_data[13] ca1_ev_data[12] ca1_ev_data[11] ca1_ev_data[10] ca1_ev_data[9] ca1_ev_data[8] ca1_ev_data[7] ca1_ev_data[6] ca1_ev_data[5] ca1_ev_data[4] ca1_ev_data[3] ca1_ev_data[2] ca1_ev_data[1] ca1_ev_data[0] -autobundled
netbloc @ca1_ev_data 1 1 1 N 810
load netBundle @ca1_ev_mesi 2 ca1_ev_mesi[1] ca1_ev_mesi[0] -autobundled
netbloc @ca1_ev_mesi 1 1 1 N 830
load netBundle @ca1_hit_data 64 ca1_hit_data[63] ca1_hit_data[62] ca1_hit_data[61] ca1_hit_data[60] ca1_hit_data[59] ca1_hit_data[58] ca1_hit_data[57] ca1_hit_data[56] ca1_hit_data[55] ca1_hit_data[54] ca1_hit_data[53] ca1_hit_data[52] ca1_hit_data[51] ca1_hit_data[50] ca1_hit_data[49] ca1_hit_data[48] ca1_hit_data[47] ca1_hit_data[46] ca1_hit_data[45] ca1_hit_data[44] ca1_hit_data[43] ca1_hit_data[42] ca1_hit_data[41] ca1_hit_data[40] ca1_hit_data[39] ca1_hit_data[38] ca1_hit_data[37] ca1_hit_data[36] ca1_hit_data[35] ca1_hit_data[34] ca1_hit_data[33] ca1_hit_data[32] ca1_hit_data[31] ca1_hit_data[30] ca1_hit_data[29] ca1_hit_data[28] ca1_hit_data[27] ca1_hit_data[26] ca1_hit_data[25] ca1_hit_data[24] ca1_hit_data[23] ca1_hit_data[22] ca1_hit_data[21] ca1_hit_data[20] ca1_hit_data[19] ca1_hit_data[18] ca1_hit_data[17] ca1_hit_data[16] ca1_hit_data[15] ca1_hit_data[14] ca1_hit_data[13] ca1_hit_data[12] ca1_hit_data[11] ca1_hit_data[10] ca1_hit_data[9] ca1_hit_data[8] ca1_hit_data[7] ca1_hit_data[6] ca1_hit_data[5] ca1_hit_data[4] ca1_hit_data[3] ca1_hit_data[2] ca1_hit_data[1] ca1_hit_data[0] -autobundled
netbloc @ca1_hit_data 1 1 1 N 870
load netBundle @ca1_hit_mesi 2 ca1_hit_mesi[1] ca1_hit_mesi[0] -autobundled
netbloc @ca1_hit_mesi 1 1 1 N 890
load netBundle @ctrl_addr_0 8 ctrl_addr_0[7] ctrl_addr_0[6] ctrl_addr_0[5] ctrl_addr_0[4] ctrl_addr_0[3] ctrl_addr_0[2] ctrl_addr_0[1] ctrl_addr_0[0] -autobundled
netbloc @ctrl_addr_0 1 2 2 NJ 250 1900
load netBundle @ctrl_cmd_0 3 ctrl_cmd_0[2] ctrl_cmd_0[1] ctrl_cmd_0[0] -autobundled
netbloc @ctrl_cmd_0 1 2 2 NJ 270 1880
load netBundle @ctrl_wdata_0 64 ctrl_wdata_0[63] ctrl_wdata_0[62] ctrl_wdata_0[61] ctrl_wdata_0[60] ctrl_wdata_0[59] ctrl_wdata_0[58] ctrl_wdata_0[57] ctrl_wdata_0[56] ctrl_wdata_0[55] ctrl_wdata_0[54] ctrl_wdata_0[53] ctrl_wdata_0[52] ctrl_wdata_0[51] ctrl_wdata_0[50] ctrl_wdata_0[49] ctrl_wdata_0[48] ctrl_wdata_0[47] ctrl_wdata_0[46] ctrl_wdata_0[45] ctrl_wdata_0[44] ctrl_wdata_0[43] ctrl_wdata_0[42] ctrl_wdata_0[41] ctrl_wdata_0[40] ctrl_wdata_0[39] ctrl_wdata_0[38] ctrl_wdata_0[37] ctrl_wdata_0[36] ctrl_wdata_0[35] ctrl_wdata_0[34] ctrl_wdata_0[33] ctrl_wdata_0[32] ctrl_wdata_0[31] ctrl_wdata_0[30] ctrl_wdata_0[29] ctrl_wdata_0[28] ctrl_wdata_0[27] ctrl_wdata_0[26] ctrl_wdata_0[25] ctrl_wdata_0[24] ctrl_wdata_0[23] ctrl_wdata_0[22] ctrl_wdata_0[21] ctrl_wdata_0[20] ctrl_wdata_0[19] ctrl_wdata_0[18] ctrl_wdata_0[17] ctrl_wdata_0[16] ctrl_wdata_0[15] ctrl_wdata_0[14] ctrl_wdata_0[13] ctrl_wdata_0[12] ctrl_wdata_0[11] ctrl_wdata_0[10] ctrl_wdata_0[9] ctrl_wdata_0[8] ctrl_wdata_0[7] ctrl_wdata_0[6] ctrl_wdata_0[5] ctrl_wdata_0[4] ctrl_wdata_0[3] ctrl_wdata_0[2] ctrl_wdata_0[1] ctrl_wdata_0[0] -autobundled
netbloc @ctrl_wdata_0 1 2 2 NJ 350 1780
load netBundle @ca0_ev_set 2 ca0_ev_set[1] ca0_ev_set[0] -autobundled
netbloc @ca0_ev_set 1 0 3 60 10 NJ 10 1290
load netBundle @ca0_lk_addr 8 ca0_lk_addr[7] ca0_lk_addr[6] ca0_lk_addr[5] ca0_lk_addr[4] ca0_lk_addr[3] ca0_lk_addr[2] ca0_lk_addr[1] ca0_lk_addr[0] -autobundled
netbloc @ca0_lk_addr 1 0 3 100 50 NJ 50 1230
load netBundle @ca0_wr_addr 8 ca0_wr_addr[7] ca0_wr_addr[6] ca0_wr_addr[5] ca0_wr_addr[4] ca0_wr_addr[3] ca0_wr_addr[2] ca0_wr_addr[1] ca0_wr_addr[0] -autobundled
netbloc @ca0_wr_addr 1 0 3 120 70 NJ 70 1210
load netBundle @ca0_wr_data 64 ca0_wr_data[63] ca0_wr_data[62] ca0_wr_data[61] ca0_wr_data[60] ca0_wr_data[59] ca0_wr_data[58] ca0_wr_data[57] ca0_wr_data[56] ca0_wr_data[55] ca0_wr_data[54] ca0_wr_data[53] ca0_wr_data[52] ca0_wr_data[51] ca0_wr_data[50] ca0_wr_data[49] ca0_wr_data[48] ca0_wr_data[47] ca0_wr_data[46] ca0_wr_data[45] ca0_wr_data[44] ca0_wr_data[43] ca0_wr_data[42] ca0_wr_data[41] ca0_wr_data[40] ca0_wr_data[39] ca0_wr_data[38] ca0_wr_data[37] ca0_wr_data[36] ca0_wr_data[35] ca0_wr_data[34] ca0_wr_data[33] ca0_wr_data[32] ca0_wr_data[31] ca0_wr_data[30] ca0_wr_data[29] ca0_wr_data[28] ca0_wr_data[27] ca0_wr_data[26] ca0_wr_data[25] ca0_wr_data[24] ca0_wr_data[23] ca0_wr_data[22] ca0_wr_data[21] ca0_wr_data[20] ca0_wr_data[19] ca0_wr_data[18] ca0_wr_data[17] ca0_wr_data[16] ca0_wr_data[15] ca0_wr_data[14] ca0_wr_data[13] ca0_wr_data[12] ca0_wr_data[11] ca0_wr_data[10] ca0_wr_data[9] ca0_wr_data[8] ca0_wr_data[7] ca0_wr_data[6] ca0_wr_data[5] ca0_wr_data[4] ca0_wr_data[3] ca0_wr_data[2] ca0_wr_data[1] ca0_wr_data[0] -autobundled
netbloc @ca0_wr_data 1 0 3 140 90 NJ 90 1190
load netBundle @ca0_wr_mesi 2 ca0_wr_mesi[1] ca0_wr_mesi[0] -autobundled
netbloc @ca0_wr_mesi 1 0 3 180 130 NJ 130 1130
load netBundle @ctrl_addr_1 8 ctrl_addr_1[7] ctrl_addr_1[6] ctrl_addr_1[5] ctrl_addr_1[4] ctrl_addr_1[3] ctrl_addr_1[2] ctrl_addr_1[1] ctrl_addr_1[0] -autobundled
netbloc @ctrl_addr_1 1 2 2 NJ 790 1860
load netBundle @ctrl_cmd_1 3 ctrl_cmd_1[2] ctrl_cmd_1[1] ctrl_cmd_1[0] -autobundled
netbloc @ctrl_cmd_1 1 2 2 NJ 810 1820
load netBundle @ctrl_wdata_1 64 ctrl_wdata_1[63] ctrl_wdata_1[62] ctrl_wdata_1[61] ctrl_wdata_1[60] ctrl_wdata_1[59] ctrl_wdata_1[58] ctrl_wdata_1[57] ctrl_wdata_1[56] ctrl_wdata_1[55] ctrl_wdata_1[54] ctrl_wdata_1[53] ctrl_wdata_1[52] ctrl_wdata_1[51] ctrl_wdata_1[50] ctrl_wdata_1[49] ctrl_wdata_1[48] ctrl_wdata_1[47] ctrl_wdata_1[46] ctrl_wdata_1[45] ctrl_wdata_1[44] ctrl_wdata_1[43] ctrl_wdata_1[42] ctrl_wdata_1[41] ctrl_wdata_1[40] ctrl_wdata_1[39] ctrl_wdata_1[38] ctrl_wdata_1[37] ctrl_wdata_1[36] ctrl_wdata_1[35] ctrl_wdata_1[34] ctrl_wdata_1[33] ctrl_wdata_1[32] ctrl_wdata_1[31] ctrl_wdata_1[30] ctrl_wdata_1[29] ctrl_wdata_1[28] ctrl_wdata_1[27] ctrl_wdata_1[26] ctrl_wdata_1[25] ctrl_wdata_1[24] ctrl_wdata_1[23] ctrl_wdata_1[22] ctrl_wdata_1[21] ctrl_wdata_1[20] ctrl_wdata_1[19] ctrl_wdata_1[18] ctrl_wdata_1[17] ctrl_wdata_1[16] ctrl_wdata_1[15] ctrl_wdata_1[14] ctrl_wdata_1[13] ctrl_wdata_1[12] ctrl_wdata_1[11] ctrl_wdata_1[10] ctrl_wdata_1[9] ctrl_wdata_1[8] ctrl_wdata_1[7] ctrl_wdata_1[6] ctrl_wdata_1[5] ctrl_wdata_1[4] ctrl_wdata_1[3] ctrl_wdata_1[2] ctrl_wdata_1[1] ctrl_wdata_1[0] -autobundled
netbloc @ctrl_wdata_1 1 2 2 NJ 890 1660
load netBundle @ca1_ev_set 2 ca1_ev_set[1] ca1_ev_set[0] -autobundled
netbloc @ca1_ev_set 1 0 3 160 650 NJ 650 1170
load netBundle @ca1_lk_addr 8 ca1_lk_addr[7] ca1_lk_addr[6] ca1_lk_addr[5] ca1_lk_addr[4] ca1_lk_addr[3] ca1_lk_addr[2] ca1_lk_addr[1] ca1_lk_addr[0] -autobundled
netbloc @ca1_lk_addr 1 0 3 140 710 630J 690 1110
load netBundle @ca1_wr_addr 8 ca1_wr_addr[7] ca1_wr_addr[6] ca1_wr_addr[5] ca1_wr_addr[4] ca1_wr_addr[3] ca1_wr_addr[2] ca1_wr_addr[1] ca1_wr_addr[0] -autobundled
netbloc @ca1_wr_addr 1 0 3 100 1210 NJ 1210 1210
load netBundle @ca1_wr_data 64 ca1_wr_data[63] ca1_wr_data[62] ca1_wr_data[61] ca1_wr_data[60] ca1_wr_data[59] ca1_wr_data[58] ca1_wr_data[57] ca1_wr_data[56] ca1_wr_data[55] ca1_wr_data[54] ca1_wr_data[53] ca1_wr_data[52] ca1_wr_data[51] ca1_wr_data[50] ca1_wr_data[49] ca1_wr_data[48] ca1_wr_data[47] ca1_wr_data[46] ca1_wr_data[45] ca1_wr_data[44] ca1_wr_data[43] ca1_wr_data[42] ca1_wr_data[41] ca1_wr_data[40] ca1_wr_data[39] ca1_wr_data[38] ca1_wr_data[37] ca1_wr_data[36] ca1_wr_data[35] ca1_wr_data[34] ca1_wr_data[33] ca1_wr_data[32] ca1_wr_data[31] ca1_wr_data[30] ca1_wr_data[29] ca1_wr_data[28] ca1_wr_data[27] ca1_wr_data[26] ca1_wr_data[25] ca1_wr_data[24] ca1_wr_data[23] ca1_wr_data[22] ca1_wr_data[21] ca1_wr_data[20] ca1_wr_data[19] ca1_wr_data[18] ca1_wr_data[17] ca1_wr_data[16] ca1_wr_data[15] ca1_wr_data[14] ca1_wr_data[13] ca1_wr_data[12] ca1_wr_data[11] ca1_wr_data[10] ca1_wr_data[9] ca1_wr_data[8] ca1_wr_data[7] ca1_wr_data[6] ca1_wr_data[5] ca1_wr_data[4] ca1_wr_data[3] ca1_wr_data[2] ca1_wr_data[1] ca1_wr_data[0] -autobundled
netbloc @ca1_wr_data 1 0 3 120 1230 NJ 1230 1190
load netBundle @ca1_wr_mesi 2 ca1_wr_mesi[1] ca1_wr_mesi[0] -autobundled
netbloc @ca1_wr_mesi 1 0 3 160 1270 NJ 1270 1130
load netBundle @mem_data 64 mem_data[63] mem_data[62] mem_data[61] mem_data[60] mem_data[59] mem_data[58] mem_data[57] mem_data[56] mem_data[55] mem_data[54] mem_data[53] mem_data[52] mem_data[51] mem_data[50] mem_data[49] mem_data[48] mem_data[47] mem_data[46] mem_data[45] mem_data[44] mem_data[43] mem_data[42] mem_data[41] mem_data[40] mem_data[39] mem_data[38] mem_data[37] mem_data[36] mem_data[35] mem_data[34] mem_data[33] mem_data[32] mem_data[31] mem_data[30] mem_data[29] mem_data[28] mem_data[27] mem_data[26] mem_data[25] mem_data[24] mem_data[23] mem_data[22] mem_data[21] mem_data[20] mem_data[19] mem_data[18] mem_data[17] mem_data[16] mem_data[15] mem_data[14] mem_data[13] mem_data[12] mem_data[11] mem_data[10] mem_data[9] mem_data[8] mem_data[7] mem_data[6] mem_data[5] mem_data[4] mem_data[3] mem_data[2] mem_data[1] mem_data[0] -autobundled
netbloc @mem_data 1 3 1 1820 1170n
load netBundle @ctrl_bus_req 2 ctrl_bus_req[1] ctrl_bus_req[0] -autobundled
netbloc @ctrl_bus_req 1 2 2 1310 850 1720
levelinfo -pg 1 0 310 910 1480 2060 2470
pagesize -pg 1 -db -bbox -sgen -150 0 2660 1720
show
zoom 0.659433
scrollpos 89 60
#
# initialize ictrl to current module top work:top:NOFILE
ictrl init topinfo |
