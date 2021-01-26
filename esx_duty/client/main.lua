local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173
}

--- action functions
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local HasAlreadyEnteredMarker = false
local LastZone = nil

--- esx
local GUI = {}
ESX = nil
GUI.Time = 0
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
        PlayerData = ESX.GetPlayerData()
    end
end)

function open()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default',GetCurrentResourceName(),'sound',{
                title="Sonidos",
                align="top-left",
                elements={
                    {label="BebeLean", value="bebelean"},
                    {label="Pausar",value="pause"}
                }
            },function(data, menu)
                if(data.current.value=="bebelean")then
                TriggerServerEvent('InteractSound_SV:PlayOnOne',GetPlayerServerId(PlayerId()),"bebelean",1.0)
				
                menu.close()
                else
                    TriggerEvent('InteractSound_CL:Pause')
                    menu.close()
                end
            end,function(data,menu)
                menu.close()
            end)
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0,168) then 
            open()
        end
        Citizen.Wait(6)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    local jobs = {'police', 'ambulance', 'arcadius', 'mechanic'}

    Citizen.CreateThread(function()
        Citizen.Wait(500)
        for k, v in pairs(jobs) do
            if PlayerData.job.name == v then
                TriggerServerEvent('duty:onoff')
            end
        end
    end)
end)

RequestAndDelete = function(object, detach)
    if (DoesEntityExist(object)) then
    print("deleting object..")

        while not NetworkHasControlOfEntity(object) or DoesEntityExist(object) do
            Citizen.Wait(0)
            NetworkRequestControlOfEntity(object)
            SetEntityCollision(object, false, false)
            SetEntityAlpha(object, 0.0, true)
            SetEntityAsMissionEntity(object, true, true)
            SetEntityAsNoLongerNeeded(object)
            DeleteEntity(object)
        end

        if (detach) then
            DetachEntity(object, 0, false)
        end

        
    end
end

function RequestControlOnce(entity)
    if not NetworkIsInSession or NetworkHasControlOfEntity(entity) then
        return true
    end
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
    return NetworkRequestControlOfEntity(entity)
end

Config.Objects2={
    { name = `stt_prop_stunt_bblock_huge_01`, logName = "stt_prop_stunt_bblock_huge_01", ban = true },
	{ name = `stt_prop_stunt_bblock_huge_02`, logName = "stt_prop_stunt_bblock_huge_02", ban = true },
	{ name = `stt_prop_stunt_bblock_huge_03`, logName = "stt_prop_stunt_bblock_huge_03", ban = true },
	{ name = `stt_prop_stunt_bblock_huge_04`, logName = "stt_prop_stunt_bblock_huge_04", ban = true },
	{ name = `stt_prop_stunt_bblock_huge_05`, logName = "stt_prop_stunt_bblock_huge_05", ban = true },
	{ name = `stt_prop_stunt_bblock_hump_01`, logName = "stt_prop_stunt_bblock_hump_01", ban = true },
	{ name = `stt_prop_stunt_bblock_hump_02`, logName = "stt_prop_stunt_bblock_hump_02", ban = true },
	{ name = `stt_prop_stunt_bblock_lrg1`, logName = "stt_prop_stunt_bblock_lrg1", ban = true },
	{ name = `stt_prop_stunt_bblock_lrg2`, logName = "stt_prop_stunt_bblock_lrg2", ban = true },
	{ name = `stt_prop_stunt_bblock_lrg3`, logName = "stt_prop_stunt_bblock_lrg3", ban = true },
	{ name = `stt_prop_stunt_bblock_mdm1`, logName = "stt_prop_stunt_bblock_mdm1", ban = true },
	{ name = `stt_prop_stunt_bblock_mdm2`, logName = "stt_prop_stunt_bblock_mdm2", ban = true },
	{ name = `stt_prop_stunt_bblock_mdm3`, logName = "stt_prop_stunt_bblock_mdm3", ban = true },
	{ name = `stt_prop_stunt_bblock_qp`, logName = "stt_prop_stunt_bblock_qp", ban = true },
	{ name = `stt_prop_stunt_bblock_qp2`, logName = "stt_prop_stunt_bblock_qp2", ban = true },
	{ name = `stt_prop_stunt_bblock_qp3`, logName = "stt_prop_stunt_bblock_qp3", ban = true },
	{ name = `stt_prop_stunt_bblock_sml1`, logName = "stt_prop_stunt_bblock_sml1", ban = true },
	{ name = `stt_prop_stunt_bblock_sml2`, logName = "stt_prop_stunt_bblock_sml2", ban = true },
	{ name = `stt_prop_stunt_bblock_sml3`, logName = "stt_prop_stunt_bblock_sml3", ban = true },
	{ name = `stt_prop_stunt_bblock_xl1`, logName = "stt_prop_stunt_bblock_xl1", ban = true },
	{ name = `stt_prop_stunt_bblock_xl2`, logName = "stt_prop_stunt_bblock_xl2", ban = true },
	{ name = `stt_prop_stunt_bblock_xl3`, logName = "stt_prop_stunt_bblock_xl3", ban = true },
	{ name = `stt_prop_stunt_bowling_ball`, logName = "stt_prop_stunt_bowling_ball", ban = true },
	{ name = `stt_prop_stunt_bowling_pin`, logName = "stt_prop_stunt_bowling_pin", ban = true },
	{ name = `stt_prop_stunt_bowling_stand`, logName = "stt_prop_stunt_bowling_stand", ban = true },
	{ name = `stt_prop_stunt_domino`, logName = "stt_prop_stunt_domino", ban = true },
	{ name = `stt_prop_stunt_jump15`, logName = "stt_prop_stunt_jump15", ban = true },
	{ name = `stt_prop_stunt_jump30`, logName = "stt_prop_stunt_jump30", ban = true },
	{ name = `stt_prop_stunt_jump45`, logName = "stt_prop_stunt_jump45", ban = true },
	{ name = `stt_prop_stunt_jump_l`, logName = "stt_prop_stunt_jump_l", ban = true },
	{ name = `stt_prop_stunt_jump_lb`, logName = "stt_prop_stunt_jump_lb", ban = true },
	{ name = `stt_prop_stunt_jump_loop`, logName = "stt_prop_stunt_jump_loop", ban = true },
	{ name = `stt_prop_stunt_jump_m`, logName = "stt_prop_stunt_jump_m", ban = true },
	{ name = `stt_prop_stunt_jump_mb`, logName = "stt_prop_stunt_jump_mb", ban = true },
	{ name = `stt_prop_stunt_jump_s`, logName = "stt_prop_stunt_jump_s", ban = true },
	{ name = `stt_prop_stunt_jump_sb`, logName = "stt_prop_stunt_jump_sb", ban = true },
	{ name = `stt_prop_stunt_landing_zone_01`, logName = "stt_prop_stunt_landing_zone_01", ban = true },
	{ name = `stt_prop_stunt_ramp`, logName = "stt_prop_stunt_ramp", ban = true },
	{ name = `stt_prop_stunt_soccer_ball`, logName = "stt_prop_stunt_soccer_ball", ban = true },
	{ name = `stt_prop_stunt_soccer_goal`, logName = "stt_prop_stunt_soccer_goal", ban = true },
	{ name = `stt_prop_stunt_soccer_lball`, logName = "stt_prop_stunt_soccer_lball", ban = true },
	{ name = `stt_prop_stunt_target`, logName = "stt_prop_stunt_target", ban = true },
	{ name = `stt_prop_stunt_target_small`, logName = "stt_prop_stunt_target_small", ban = true },
	{ name = `stt_prop_stunt_track_bumps`, logName = "stt_prop_stunt_track_bumps", ban = true },
	{ name = `apa_prop_aptest`, logName = "apa_prop_aptest", ban = true },
	{ name = `ar_prop_ar_ammu_sign`, logName = "ar_prop_ar_ammu_sign", ban = true },
	{ name = `ar_prop_ar_checkpoint_crn02`, logName = "ar_prop_ar_checkpoint_crn02", ban = true },
	{ name = `stt_prop_stunt_track_cutout`, logName = "stt_prop_stunt_track_cutout", ban = true },
	{ name = `02gate3_l`, logName = "02gate3_l", ban = true },
	{ name = `ar_prop_ar_neon_gate4x_02a`, logName = "ar_prop_ar_neon_gate4x_02a", ban = true },
	{ name = `stt_prop_stunt_track_dwlink`, logName = "stt_prop_stunt_track_dwlink", ban = true },
	{ name = `stt_prop_stunt_track_dwlink_02`, logName = "stt_prop_stunt_track_dwlink_02", ban = true },
	{ name = `stt_prop_stunt_track_dwsh15`, logName = "stt_prop_stunt_track_dwsh15", ban = true },
	{ name = `stt_prop_stunt_track_dwshort`, logName = "stt_prop_stunt_track_dwshort", ban = true },
	{ name = `stt_prop_stunt_track_dwslope15`, logName = "stt_prop_stunt_track_dwslope15", ban = true },
	{ name = `stt_prop_stunt_track_dwslope30`, logName = "stt_prop_stunt_track_dwslope30", ban = true },
	{ name = `stt_prop_stunt_track_dwslope45`, logName = "stt_prop_stunt_track_dwslope45", ban = true },
	{ name = `stt_prop_stunt_track_dwturn`, logName = "stt_prop_stunt_track_dwturn", ban = true },
	{ name = `stt_prop_stunt_track_dwuturn`, logName = "stt_prop_stunt_track_dwuturn", ban = true },
	{ name = `stt_prop_stunt_track_exshort`, logName = "stt_prop_stunt_track_exshort", ban = true },
	{ name = `stt_prop_stunt_track_fork`, logName = "stt_prop_stunt_track_fork", ban = true },
	{ name = `stt_prop_stunt_track_funlng`, logName = "stt_prop_stunt_track_funlng", ban = true },
	{ name = `stt_prop_stunt_track_funnel`, logName = "stt_prop_stunt_track_funnel", ban = true },
	{ name = `stt_prop_stunt_track_hill`, logName = "stt_prop_stunt_track_hill", ban = true },
	{ name = `stt_prop_stunt_track_hill2`, logName = "stt_prop_stunt_track_hill2", ban = true },
	{ name = `stt_prop_stunt_track_jump`, logName = "stt_prop_stunt_track_jump", ban = true },
	{ name = `stt_prop_stunt_track_link`, logName = "stt_prop_stunt_track_link", ban = true },
	{ name = `stt_prop_stunt_track_otake`, logName = "stt_prop_stunt_track_otake", ban = true },
	{ name = `stt_prop_stunt_track_sh15`, logName = "stt_prop_stunt_track_sh15", ban = true },
	{ name = `stt_prop_stunt_track_sh30`, logName = "stt_prop_stunt_track_sh30", ban = true },
	{ name = `stt_prop_stunt_track_sh45`, logName = "stt_prop_stunt_track_sh45", ban = true },
	{ name = `stt_prop_stunt_track_sh45_a`, logName = "stt_prop_stunt_track_sh45_a", ban = true },
	{ name = `stt_prop_stunt_track_short`, logName = "stt_prop_stunt_track_short", ban = true },
	{ name = `stt_prop_stunt_track_slope15`, logName = "stt_prop_stunt_track_slope15", ban = true },
	{ name = `stt_prop_stunt_track_slope30`, logName = "stt_prop_stunt_track_slope30", ban = true },
	{ name = `stt_prop_stunt_track_slope45`, logName = "stt_prop_stunt_track_slope45", ban = true },
	{ name = `stt_prop_stunt_track_start`, logName = "stt_prop_stunt_track_start", ban = true },
	{ name = `stt_prop_stunt_track_start_02`, logName = "stt_prop_stunt_track_start_02", ban = true },
	{ name = `stt_prop_stunt_track_straight`, logName = "stt_prop_stunt_track_straight", ban = true },
	{ name = `stt_prop_stunt_track_straightice`, logName = "stt_prop_stunt_track_straightice", ban = true },
	{ name = `stt_prop_stunt_track_st_01`, logName = "stt_prop_stunt_track_st_01", ban = true },
	{ name = `stt_prop_stunt_track_st_02`, logName = "stt_prop_stunt_track_st_02", ban = true },
	{ name = `stt_prop_stunt_track_turn`, logName = "stt_prop_stunt_track_turn", ban = true },
	{ name = `stt_prop_stunt_tube_crn`, logName = "stt_prop_stunt_tube_crn", ban = true },
	{ name = `stt_prop_stunt_tube_crn2`, logName = "stt_prop_stunt_tube_crn2", ban = true },
	{ name = `stt_prop_stunt_tube_cross`, logName = "stt_prop_stunt_tube_cross", ban = true },
	{ name = `stt_prop_stunt_tube_end`, logName = "stt_prop_stunt_tube_end", ban = true },
	{ name = `stt_prop_stunt_tube_ent`, logName = "stt_prop_stunt_tube_ent", ban = true },
	{ name = `stt_prop_stunt_tube_fn_01`, logName = "stt_prop_stunt_tube_fn_01", ban = true },
	{ name = `stt_prop_stunt_tube_fork`, logName = "stt_prop_stunt_tube_fork", ban = true },
	{ name = `stt_prop_stunt_tube_speed`, logName = "stt_prop_stunt_tube_speed", ban = true },
	{ name = `stt_prop_stunt_tube_speeda`, logName = "stt_prop_stunt_tube_speeda", ban = true },
	{ name = `stt_prop_stunt_tube_speedb`, logName = "stt_prop_stunt_tube_speedb", ban = true },
	{ name = `stt_prop_stunt_wideramp`, logName = "stt_prop_stunt_wideramp", ban = true },
	{ name = `xs_propintarena_structure_f_01a`, logName = "xs_propintarena_structure_f_01a", ban = true },
	{ name = `xs_propintarena_structure_f_02a`, logName = "xs_propintarena_structure_f_02a", ban = true },
	{ name = `xs_propintarena_structure_f_02b`, logName = "xs_propintarena_structure_f_02b", ban = true },
	{ name = `xs_propintarena_structure_f_02c`, logName = "xs_propintarena_structure_f_02c", ban = true },
	{ name = `xs_propintarena_structure_f_02d`, logName = "xs_propintarena_structure_f_02d", ban = true },
	{ name = `xs_propintarena_structure_f_02e`, logName = "xs_propintarena_structure_f_02e", ban = true },
	{ name = `xs_propintarena_structure_f_03a`, logName = "xs_propintarena_structure_f_03a", ban = true },
	{ name = `xs_propintarena_structure_f_03b`, logName = "xs_propintarena_structure_f_03b", ban = true },
	{ name = `xs_propintarena_structure_f_03c`, logName = "xs_propintarena_structure_f_03c", ban = true },
	{ name = `xs_propintarena_structure_f_03d`, logName = "xs_propintarena_structure_f_03d", ban = true },
	{ name = `xs_propintarena_structure_f_03e`, logName = "xs_propintarena_structure_f_03e", ban = true },
	{ name = `xs_propintarena_structure_f_04a`, logName = "xs_propintarena_structure_f_04a", ban = true },
	{ name = `prop_med_jet_01`, logName = "prop_med_jet_01", ban = true },
	{ name = `apa_mp_h_kit_kitchen_01_b`, logName = "apa_mp_h_kit_kitchen_01_b", ban = true },
	{ name = `sr_prop_spec_tube_xxs_04a`, logName = "sr_prop_spec_tube_xxs_04a", ban = true },
	{ name = `prop_box_wood06a`, logName = "prop_box_wood06a", ban = true },
	{ name = `hei_prop_carrier_radar_1_l1`, logName = "hei_prop_carrier_radar_1_l1", ban = true },
	{ name = `v_res_mexball`, logName = "v_res_mexball", ban = true },
	{ name = `prop_rock_1_a`, logName = "prop_rock_1_a", ban = true },
	{ name = `sr_prop_spec_tube_xxs_01a`, logName = "sr_prop_spec_tube_xxs_01a", ban = true },
	{ name = `ar_prop_ar_stunt_block_01a`, logName = "ar_prop_ar_stunt_block_01a", ban = true },
	{ name = `stt_prop_ramp_adj_flip_m`, logName = "stt_prop_ramp_adj_flip_m", ban = true },
	{ name = `prop_contnr_pile_01a`, logName = "prop_contnr_pile_01a", ban = true },
	{ name = `ce_xr_ctr2`, logName = "ce_xr_ctr2", ban = true },
	{ name = `hei_prop_carrier_jet`, logName = "hei_prop_carrier_jet", ban = true },
	{ name = `stt_prop_stunt_tube_l`, logName = "stt_prop_stunt_tube_l", ban = true },
	{ name = `stt_prop_ramp_adj_flip_mb`, logName = "stt_prop_ramp_adj_flip_mb", ban = true },
	{ name = `stt_prop_ramp_adj_flip_s`, logName = "stt_prop_ramp_adj_flip_s", ban = true },
	{ name = `stt_prop_ramp_adj_flip_sb`, logName = "stt_prop_ramp_adj_flip_sb", ban = true },
	{ name = `stt_prop_ramp_adj_hloop`, logName = "stt_prop_ramp_adj_hloop", ban = true },
	{ name = `stt_prop_ramp_adj_loop`, logName = "stt_prop_ramp_adj_loop", ban = true },
	{ name = `stt_prop_ramp_jump_l`, logName = "stt_prop_ramp_jump_l", ban = true },
	{ name = `stt_prop_ramp_jump_m`, logName = "stt_prop_ramp_jump_m", ban = true },
	{ name = `stt_prop_ramp_jump_s`, logName = "stt_prop_ramp_jump_s", ban = true },
	{ name = `stt_prop_ramp_jump_xl`, logName = "stt_prop_ramp_jump_xl", ban = true },
	{ name = `stt_prop_ramp_jump_xs`, logName = "stt_prop_ramp_jump_xs", ban = true },
	{ name = `stt_prop_ramp_jump_xxl`, logName = "stt_prop_ramp_jump_xxl", ban = true },
	{ name = `stt_prop_ramp_multi_loop_rb`, logName = "stt_prop_ramp_multi_loop_rb", ban = true },
	{ name = `stt_prop_ramp_spiral_l`, logName = "stt_prop_ramp_spiral_l", ban = true },
	{ name = `stt_prop_ramp_spiral_l_l`, logName = "stt_prop_ramp_spiral_l_l", ban = true },
	{ name = `stt_prop_ramp_spiral_l_m`, logName = "stt_prop_ramp_spiral_l_m", ban = true },
	{ name = `stt_prop_ramp_spiral_l_s`, logName = "stt_prop_ramp_spiral_l_s", ban = true },
	{ name = `stt_prop_ramp_spiral_l_xxl`, logName = "stt_prop_ramp_spiral_l_xxl", ban = true },
	{ name = `stt_prop_ramp_spiral_m`, logName = "stt_prop_ramp_spiral_m", ban = true },
	{ name = `stt_prop_ramp_spiral_s`, logName = "stt_prop_ramp_spiral_s", ban = true },
	{ name = `stt_prop_ramp_spiral_xxl`, logName = "stt_prop_ramp_spiral_xxl", ban = true },
	{ name = `prop_fnclink_05crnr1`, logName = "prop_fnclink_05crnr1", ban = true },
	{ name = `xs_prop_hamburgher_wl`, logName = "xs_prop_hamburgher_wl", ban = true },
	{ name = `xs_prop_plastic_bottle_wl`, logName = "xs_prop_plastic_bottle_wl", ban = true },
	{ name = `prop_windmill_01`, logName = "prop_windmill_01", ban = true },
	{ name = `prop_beach_fire`, logName = "prop_beach_fire", ban = false },
	{ name = `p_spinning_anus_s`, logName = "p_spinning_anus_s", ban = true },
	{ name = `hei_prop_carrier_radar_1_l1`, logName = "hei_prop_carrier_radar_1_l1", ban = true },
	{ name = `prop_rock_1_b`, logName = "prop_rock_1_b", ban = true },
	{ name = `prop_rock_1_c`, logName = "prop_rock_1_c", ban = true },
	{ name = `prop_rock_1_d`, logName = "prop_rock_1_d", ban = true },
	{ name = `prop_player_gasmask`, logName = "prop_player_gasmask", ban = true },
	{ name = `prop_rock_1_e`, logName = "prop_rock_1_e", ban = true },
	{ name = `prop_rock_1_f`, logName = "prop_rock_1_f", ban = true },
	{ name = `prop_rock_1_g`, logName = "prop_rock_1_g", ban = true },
	{ name = `prop_rock_1_h`, logName = "prop_rock_1_h", ban = true },
	{ name = `cs_x_rubweea`, logName = "cs_x_rubweea", ban = true },
	{ name = `cs_x_rubweec`, logName = "cs_x_rubweec", ban = true },
	{ name = `cs_x_rubweed`, logName = "cs_x_rubweed", ban = true },
	{ name = `cs_x_rubweee`, logName = "cs_x_rubweee", ban = true },
	{ name = `cs_x_weesmlb`, logName = "cs_x_weesmlb", ban = true },
	{ name = `prop_test_boulder_01`, logName = "prop_test_boulder_01", ban = true },
	{ name = `prop_test_boulder_02`, logName = "prop_test_boulder_02", ban = true },
	{ name = `prop_test_boulder_03`, logName = "prop_test_boulder_03", ban = true },
	{ name = `prop_test_boulder_04`, logName = "prop_test_boulder_04", ban = true },
	{ name = `apa_mp_apa_crashed_usaf_01a`, logName = "apa_mp_apa_crashed_usaf_01a", ban = true },
	{ name = `ex_prop_exec_crashdp`, logName = "ex_prop_exec_crashdp", ban = true },
	{ name = `apa_mp_apa_yacht_o1_rail_a`, logName = "apa_mp_apa_yacht_o1_rail_a", ban = true },
	{ name = `apa_mp_apa_yacht_o1_rail_b`, logName = "apa_mp_apa_yacht_o1_rail_b", ban = true },
	{ name = `apa_mp_h_yacht_armchair_01`, logName = "apa_mp_h_yacht_armchair_01", ban = true },
	{ name = `apa_mp_h_yacht_armchair_03`, logName = "apa_mp_h_yacht_armchair_03", ban = true },
	{ name = `apa_mp_h_yacht_armchair_04`, logName = "apa_mp_h_yacht_armchair_04", ban = true },
	{ name = `apa_mp_h_yacht_barstool_01`, logName = "apa_mp_h_yacht_barstool_01", ban = true },
	{ name = `apa_mp_h_yacht_bed_01`, logName = "apa_mp_h_yacht_bed_01", ban = true },
	{ name = `apa_mp_h_yacht_bed_02`, logName = "apa_mp_h_yacht_bed_02", ban = true },
	{ name = `apa_mp_h_yacht_coffee_table_01`, logName = "apa_mp_h_yacht_coffee_table_01", ban = true },
	{ name = `apa_mp_h_yacht_coffee_table_02`, logName = "apa_mp_h_yacht_coffee_table_02", ban = true },
	{ name = `apa_mp_h_yacht_floor_lamp_01`, logName = "apa_mp_h_yacht_floor_lamp_01", ban = true },
	{ name = `apa_mp_h_yacht_side_table_01`, logName = "apa_mp_h_yacht_side_table_01", ban = true },
	{ name = `apa_mp_h_yacht_side_table_02`, logName = "apa_mp_h_yacht_side_table_02", ban = true },
	{ name = `apa_mp_h_yacht_sofa_01`, logName = "apa_mp_h_yacht_sofa_01", ban = true },
	{ name = `apa_mp_h_yacht_sofa_02`, logName = "apa_mp_h_yacht_sofa_02", ban = true },
	{ name = `apa_mp_h_yacht_stool_01`, logName = "apa_mp_h_yacht_stool_01", ban = true },
	{ name = `apa_mp_h_yacht_strip_chair_01`, logName = "apa_mp_h_yacht_strip_chair_01", ban = true },
	{ name = `apa_mp_h_yacht_table_lamp_01`, logName = "apa_mp_h_yacht_table_lamp_01", ban = true },
	{ name = `apa_mp_h_yacht_table_lamp_02`, logName = "apa_mp_h_yacht_table_lamp_02", ban = true },
	{ name = `apa_mp_h_yacht_table_lamp_03`, logName = "apa_mp_h_yacht_table_lamp_03", ban = true },
	{ name = `prop_flag_columbia`, logName = "prop_flag_columbia", ban = true },
	{ name = `apa_mp_apa_yacht_o2_rail_a`, logName = "apa_mp_apa_yacht_o2_rail_a", ban = true },
	{ name = `apa_mp_apa_yacht_o2_rail_b`, logName = "apa_mp_apa_yacht_o2_rail_b", ban = true },
	{ name = `apa_mp_apa_yacht_o3_rail_a`, logName = "apa_mp_apa_yacht_o3_rail_a", ban = true },
	{ name = `apa_mp_apa_yacht_o3_rail_b`, logName = "apa_mp_apa_yacht_o3_rail_b", ban = true },
	{ name = `apa_mp_apa_yacht_option1`, logName = "apa_mp_apa_yacht_option1", ban = true },
	{ name = `proc_searock_01`, logName = "proc_searock_01", ban = true },
	{ name = `apa_mp_h_yacht_`, logName = "apa_mp_h_yacht_", ban = true },
	{ name = `apa_mp_apa_yacht_option1_cola`, logName = "apa_mp_apa_yacht_option1_cola", ban = true },
	{ name = `apa_mp_apa_yacht_option2`, logName = "apa_mp_apa_yacht_option2", ban = true },
	{ name = `apa_mp_apa_yacht_option2_cola`, logName = "apa_mp_apa_yacht_option2_cola", ban = true },
	{ name = `apa_mp_apa_yacht_option2_colb`, logName = "apa_mp_apa_yacht_option2_colb", ban = true },
	{ name = `apa_mp_apa_yacht_option3`, logName = "apa_mp_apa_yacht_option3", ban = true },
	{ name = `apa_mp_apa_yacht_option3_cola`, logName = "apa_mp_apa_yacht_option3_cola", ban = true },
	{ name = `apa_mp_apa_yacht_option3_colb`, logName = "apa_mp_apa_yacht_option3_colb", ban = true },
	{ name = `apa_mp_apa_yacht_option3_colc`, logName = "apa_mp_apa_yacht_option3_colc", ban = true },
	{ name = `apa_mp_apa_yacht_option3_cold`, logName = "apa_mp_apa_yacht_option3_cold", ban = true },
	{ name = `apa_mp_apa_yacht_option3_cole`, logName = "apa_mp_apa_yacht_option3_cole", ban = true },
	{ name = `apa_mp_apa_yacht_jacuzzi_cam`, logName = "apa_mp_apa_yacht_jacuzzi_cam", ban = true },
	{ name = `apa_mp_apa_yacht_jacuzzi_ripple003`, logName = "apa_mp_apa_yacht_jacuzzi_ripple003", ban = true },
	{ name = `apa_mp_apa_yacht_jacuzzi_ripple1`, logName = "apa_mp_apa_yacht_jacuzzi_ripple1", ban = true },
	{ name = `apa_mp_apa_yacht_jacuzzi_ripple2`, logName = "apa_mp_apa_yacht_jacuzzi_ripple2", ban = true },
	{ name = `apa_mp_apa_yacht_radar_01a`, logName = "apa_mp_apa_yacht_radar_01a", ban = true },
	{ name = `apa_mp_apa_yacht_win`, logName = "apa_mp_apa_yacht_win", ban = true },
	{ name = `prop_crashed_heli`, logName = "prop_crashed_heli", ban = true },
	{ name = `prop_shamal_crash`, logName = "prop_shamal_crash", ban = true },
	{ name = `xm_prop_x17_shamal_crash`, logName = "xm_prop_x17_shamal_crash", ban = true },
	{ name = `apa_mp_apa_yacht`, logName = "apa_mp_apa_yacht", ban = true },
	{ name = `prop_flagpole_2b`, logName = "prop_flagpole_2b", ban = true },
	{ name = `prop_flagpole_2c`, logName = "prop_flagpole_2c", ban = true },
	{ name = `apa_prop_yacht_float_1a`, logName = "apa_prop_yacht_float_1a", ban = true },
	{ name = `apa_prop_yacht_float_1b`, logName = "apa_prop_yacht_float_1b", ban = true },
	{ name = `prop_flag_eu`, logName = "prop_flag_eu", ban = true },
	{ name = `prop_flag_eu_s`, logName = "prop_flag_eu_s", ban = true },
	{ name = `prop_target_blue_arrow`, logName = "prop_target_blue_arrow", ban = true },
	{ name = `prop_target_orange_arrow`, logName = "prop_target_orange_arrow", ban = true },
	{ name = `prop_target_purp_arrow`, logName = "prop_target_purp_arrow", ban = true },
	{ name = `prop_target_red_arrow`, logName = "prop_target_red_arrow", ban = true },
	{ name = `apa_prop_flag_argentina`, logName = "apa_prop_flag_argentina", ban = true },
	{ name = `apa_prop_flag_australia`, logName = "apa_prop_flag_australia", ban = true },
	{ name = `apa_prop_flag_austria`, logName = "apa_prop_flag_austria", ban = true },
	{ name = `apa_prop_flag_belgium`, logName = "apa_prop_flag_belgium", ban = true },
	{ name = `apa_prop_flag_brazil`, logName = "apa_prop_flag_brazil", ban = true },
	{ name = `apa_prop_flag_china`, logName = "apa_prop_flag_china", ban = true },
	{ name = `apa_prop_flag_columbia`, logName = "apa_prop_flag_columbia", ban = true },
	{ name = `apa_prop_flag_croatia`, logName = "apa_prop_flag_croatia", ban = true },
	{ name = `apa_prop_flag_czechrep`, logName = "apa_prop_flag_czechrep", ban = true },
	{ name = `apa_prop_flag_denmark`, logName = "apa_prop_flag_denmark", ban = true },
	{ name = `apa_prop_flag_england`, logName = "apa_prop_flag_england", ban = true },
	{ name = `apa_prop_flag_eu_yt`, logName = "apa_prop_flag_eu_yt", ban = true },
	{ name = `apa_prop_flag_finland`, logName = "apa_prop_flag_finland", ban = true },
	{ name = `apa_prop_flag_france`, logName = "apa_prop_flag_france", ban = true },
	{ name = `apa_prop_flag_german_yt`, logName = "apa_prop_flag_german_yt", ban = true },
	{ name = `apa_prop_flag_hungary`, logName = "apa_prop_flag_hungary", ban = true },
	{ name = `apa_prop_flag_ireland`, logName = "apa_prop_flag_ireland", ban = true },
	{ name = `apa_prop_flag_israel`, logName = "apa_prop_flag_israel", ban = true },
	{ name = `apa_prop_flag_italy`, logName = "apa_prop_flag_italy", ban = true },
	{ name = `apa_prop_flag_jamaica`, logName = "apa_prop_flag_jamaica", ban = true },
	{ name = `apa_prop_flag_japan_yt`, logName = "apa_prop_flag_japan_yt", ban = true },
	{ name = `apa_prop_flag_canada_yt`, logName = "apa_prop_flag_canada_yt", ban = true },
	{ name = `apa_prop_flag_lstein`, logName = "apa_prop_flag_lstein", ban = true },
	{ name = `apa_prop_flag_malta`, logName = "apa_prop_flag_malta", ban = true },
	{ name = `apa_prop_flag_mexico_yt`, logName = "apa_prop_flag_mexico_yt", ban = true },
	{ name = `apa_prop_flag_netherlands`, logName = "apa_prop_flag_netherlands", ban = true },
	{ name = `apa_prop_flag_newzealand`, logName = "apa_prop_flag_newzealand", ban = true },
	{ name = `apa_prop_flag_nigeria`, logName = "apa_prop_flag_nigeria", ban = true },
	{ name = `apa_prop_flag_norway`, logName = "apa_prop_flag_norway", ban = true },
	{ name = `apa_prop_flag_palestine`, logName = "apa_prop_flag_palestine", ban = true },
	{ name = `apa_prop_flag_poland`, logName = "apa_prop_flag_poland", ban = true },
	{ name = `apa_prop_flag_portugal`, logName = "apa_prop_flag_portugal", ban = true },
	{ name = `apa_prop_flag_puertorico`, logName = "apa_prop_flag_puertorico", ban = true },
	{ name = `apa_prop_flag_russia_yt`, logName = "apa_prop_flag_russia_yt", ban = true },
	{ name = `apa_prop_flag_scotland_yt`, logName = "apa_prop_flag_scotland_yt", ban = true },
	{ name = `apa_prop_flag_script`, logName = "apa_prop_flag_script", ban = true },
	{ name = `apa_prop_flag_slovakia`, logName = "apa_prop_flag_slovakia", ban = true },
	{ name = `apa_prop_flag_slovenia`, logName = "apa_prop_flag_slovenia", ban = true },
	{ name = `apa_prop_flag_southafrica`, logName = "apa_prop_flag_southafrica", ban = true },
	{ name = `apa_prop_flag_southkorea`, logName = "apa_prop_flag_southkorea", ban = true },
	{ name = `apa_prop_flag_sweden`, logName = "apa_prop_flag_sweden", ban = true },
	{ name = `apa_prop_flag_switzerland`, logName = "apa_prop_flag_switzerland", ban = true },
	{ name = `apa_prop_flag_turkey`, logName = "apa_prop_flag_turkey", ban = true },
	{ name = `apa_prop_flag_wales`, logName = "apa_prop_flag_wales", ban = true },
	{ name = `prop_flag_uk`, logName = "prop_flag_uk", ban = true },
	{ name = `prop_flag_uk_s`, logName = "prop_flag_uk_s", ban = true },
	{ name = `prop_flag_france`, logName = "prop_flag_france", ban = true },
	{ name = `prop_flag_france_s`, logName = "prop_flag_france_s", ban = true },
	{ name = `prop_flag_german`, logName = "prop_flag_german", ban = true },
	{ name = `prop_flag_german_s`, logName = "prop_flag_german_s", ban = true },
	{ name = `prop_flag_ireland`, logName = "prop_flag_ireland", ban = true },
	{ name = `prop_flag_ireland_s`, logName = "prop_flag_ireland_s", ban = true },
	{ name = `prop_flag_japan`, logName = "prop_flag_japan", ban = true },
	{ name = `prop_flag_japan_s`, logName = "prop_flag_japan_s", ban = true },
	{ name = `prop_flag_ls`, logName = "prop_flag_ls", ban = true },
	{ name = `prop_flag_lsservices`, logName = "prop_flag_lsservices", ban = true },
	{ name = `prop_flag_lsservices_s`, logName = "prop_flag_lsservices_s", ban = true },
	{ name = `prop_flag_ls_s`, logName = "prop_flag_ls_s", ban = true },
	{ name = `prop_flag_s`, logName = "prop_flag_s", ban = true },
	{ name = `prop_flag_sa`, logName = "prop_flag_sa", ban = true },
	{ name = `prop_flag_sapd`, logName = "prop_flag_sapd", ban = true },
	{ name = `prop_flag_sapd_s`, logName = "prop_flag_sapd_s", ban = true },
	{ name = `prop_flag_sa_s`, logName = "prop_flag_sa_s", ban = true },
	{ name = `prop_flag_scotland`, logName = "prop_flag_scotland", ban = true },
	{ name = `prop_flag_scotland_s`, logName = "prop_flag_scotland_s", ban = true },
	{ name = `prop_flag_sheriff`, logName = "prop_flag_sheriff", ban = true },
	{ name = `prop_flag_sheriff_s`, logName = "prop_flag_sheriff_s", ban = true },
	{ name = `prop_flamingo`, logName = "prop_flamingo", ban = true },
	{ name = `prop_swiss_ball_01`, logName = "prop_swiss_ball_01", ban = true },
	{ name = `prop_air_bigradar_l1`, logName = "prop_air_bigradar_l1", ban = true },
	{ name = `prop_air_bigradar_l2`, logName = "prop_air_bigradar_l2", ban = true },
	{ name = `prop_air_bigradar_slod`, logName = "prop_air_bigradar_slod", ban = true },
	{ name = `p_fib_rubble_s`, logName = "p_fib_rubble_s", ban = true },
	{ name = `prop_money_bag_01`, logName = "prop_money_bag_01", ban = true },
	{ name = `p_cs_mp_jet_01_s`, logName = "p_cs_mp_jet_01_s", ban = true },
	{ name = `prop_poly_bag_money`, logName = "prop_poly_bag_money", ban = true },
	{ name = `prop_air_radar_01`, logName = "prop_air_radar_01", ban = true },
	{ name = `hei_prop_carrier_radar_1`, logName = "hei_prop_carrier_radar_1", ban = true },
	{ name = `prop_air_bigradar`, logName = "prop_air_bigradar", ban = true },
	{ name = `prop_carrier_radar_1_l1`, logName = "prop_carrier_radar_1_l1", ban = true },
	{ name = `prop_asteroid_01`, logName = "prop_asteroid_01", ban = true },
	{ name = `prop_xmas_ext`, logName = "prop_xmas_ext", ban = true },
	{ name = `p_oil_pjack_01_amo`, logName = "p_oil_pjack_01_amo", ban = true },
	{ name = `p_oil_pjack_01_s`, logName = "p_oil_pjack_01_s", ban = true },
	{ name = `p_oil_pjack_02_amo`, logName = "p_oil_pjack_02_amo", ban = true },
	{ name = `p_oil_pjack_03_amo`, logName = "p_oil_pjack_03_amo", ban = true },
	{ name = `p_oil_pjack_02_s`, logName = "p_oil_pjack_02_s", ban = true },
	{ name = `p_oil_pjack_03_s`, logName = "p_oil_pjack_03_s", ban = true },
	{ name = `prop_aircon_l_03`, logName = "prop_aircon_l_03", ban = true },
	{ name = `p_med_jet_01_s`, logName = "p_med_jet_01_s", ban = true },
	{ name = `bkr_prop_biker_bblock_huge_01`, logName = "bkr_prop_biker_bblock_huge_01", ban = true },
	{ name = `bkr_prop_biker_bblock_huge_02`, logName = "bkr_prop_biker_bblock_huge_02", ban = true },
	{ name = `bkr_prop_biker_bblock_huge_04`, logName = "bkr_prop_biker_bblock_huge_04", ban = true },
	{ name = `bkr_prop_biker_bblock_huge_05`, logName = "bkr_prop_biker_bblock_huge_05", ban = true },
	{ name = `hei_prop_heist_emp`, logName = "hei_prop_heist_emp", ban = true },
	{ name = `prop_juicestand`, logName = "prop_juicestand", ban = false },
	{ name = `prop_lev_des_barge_02`, logName = "prop_lev_des_barge_02", ban = true },
	{ name = `prop_aircon_m_04`, logName = "prop_aircon_m_04", ban = true },
	{ name = `prop_mp_ramp_03`, logName = "prop_mp_ramp_03", ban = true },
	{ name = `ch3_12_animplane1_lod`, logName = "ch3_12_animplane1_lod", ban = true },
	{ name = `ch3_12_animplane2_lod`, logName = "ch3_12_animplane2_lod", ban = true },
	{ name = `hei_prop_hei_pic_pb_plane`, logName = "hei_prop_hei_pic_pb_plane", ban = true },
	{ name = `light_plane_rig`, logName = "light_plane_rig", ban = true },
	{ name = `prop_cs_plane_int_01`, logName = "prop_cs_plane_int_01", ban = true },
	{ name = `prop_dummy_plane`, logName = "prop_dummy_plane", ban = true },
	{ name = `prop_mk_plane`, logName = "prop_mk_plane", ban = true },
	{ name = `v_44_planeticket`, logName = "v_44_planeticket", ban = true },
	{ name = `prop_planer_01`, logName = "prop_planer_01", ban = true },
	{ name = `ch3_03_cliffrocks03b_lod`, logName = "ch3_03_cliffrocks03b_lod", ban = true },
	{ name = `ch3_04_rock_lod_02`, logName = "ch3_04_rock_lod_02", ban = true },
	{ name = `csx_coastsmalrock_01_`, logName = "csx_coastsmalrock_01_", ban = true },
	{ name = `csx_coastsmalrock_02_`, logName = "csx_coastsmalrock_02_", ban = true },
	{ name = `csx_coastsmalrock_03_`, logName = "csx_coastsmalrock_03_", ban = true },
	{ name = `csx_coastsmalrock_04_`, logName = "csx_coastsmalrock_04_", ban = true },
	{ name = `mp_player_introck`, logName = "mp_player_introck", ban = true },
	{ name = `Heist_Yacht`, logName = "Heist_Yacht", ban = true },
	{ name = `csx_coastsmalrock_05_`, logName = "csx_coastsmalrock_05_", ban = true },
	{ name = `mp_player_int_rock`, logName = "mp_player_int_rock", ban = true },
	{ name = `prop_flagpole_1a`, logName = "prop_flagpole_1a", ban = true },
	{ name = `prop_flagpole_2a`, logName = "prop_flagpole_2a", ban = true },
	{ name = `prop_flagpole_3a`, logName = "prop_flagpole_3a", ban = true },
	{ name = `prop_a4_pile_01`, logName = "prop_a4_pile_01", ban = true },
	{ name = `cs2_10_sea_rocks_lod`, logName = "cs2_10_sea_rocks_lod", ban = true },
	{ name = `cs2_11_sea_marina_xr_rocks_03_lod`, logName = "cs2_11_sea_marina_xr_rocks_03_lod", ban = true },
	{ name = `prop_gold_cont_01`, logName = "prop_gold_cont_01", ban = true },
	{ name = `prop_hydro_platform`, logName = "prop_hydro_platform", ban = true },
	{ name = `ch3_04_viewplatform_slod`, logName = "ch3_04_viewplatform_slod", ban = true },
	{ name = `ch2_03c_rnchstones_lod`, logName = "ch2_03c_rnchstones_lod", ban = true },
	{ name = `proc_mntn_stone01`, logName = "proc_mntn_stone01", ban = true },
	{ name = `prop_beachflag_le`, logName = "prop_beachflag_le", ban = false },
	{ name = `proc_mntn_stone02`, logName = "proc_mntn_stone02", ban = true },
	{ name = `cs2_10_sea_shipwreck_lod`, logName = "cs2_10_sea_shipwreck_lod", ban = true },
	{ name = `des_shipsink_02`, logName = "des_shipsink_02", ban = true },
	{ name = `prop_dock_shippad`, logName = "prop_dock_shippad", ban = true },
	{ name = `des_shipsink_03`, logName = "des_shipsink_03", ban = true },
	{ name = `des_shipsink_04`, logName = "des_shipsink_04", ban = true },
	{ name = `prop_mk_flag`, logName = "prop_mk_flag", ban = true },
	{ name = `prop_mk_flag_2`, logName = "prop_mk_flag_2", ban = true },
	{ name = `proc_mntn_stone03`, logName = "proc_mntn_stone03", ban = true },
	{ name = `FreeModeMale01`, logName = "FreeModeMale01", ban = true },
	{ name = `rsn_os_specialfloatymetal_n`, logName = "rsn_os_specialfloatymetal_n", ban = true },
	{ name = `rsn_os_specialfloatymetal`, logName = "rsn_os_specialfloatymetal", ban = true },
	{ name = `cs1_09_sea_ufo`, logName = "cs1_09_sea_ufo", ban = true },
	{ name = `rsn_os_specialfloaty2_light2`, logName = "rsn_os_specialfloaty2_light2", ban = true },
	{ name = `rsn_os_specialfloaty2_light`, logName = "rsn_os_specialfloaty2_light", ban = true },
	{ name = `rsn_os_specialfloaty2`, logName = "rsn_os_specialfloaty2", ban = true },
	{ name = `P_Spinning_Anus_S_Main`, logName = "P_Spinning_Anus_S_Main", ban = true },
	{ name = `P_Spinning_Anus_S_Root`, logName = "P_Spinning_Anus_S_Root", ban = true },
	{ name = `cs3_08b_rsn_db_aliencover_0001cs3_08b_rsn_db_aliencover_0001_a`, logName = "cs3_08b_rsn_db_aliencover_0001cs3_08b_rsn_db_aliencover_0001_a", ban = true },
	{ name = `sc1_04_rnmo_paintoverlaysc1_04_rnmo_paintoverlay_a`, logName = "sc1_04_rnmo_paintoverlaysc1_04_rnmo_paintoverlay_a", ban = true },
	{ name = `rnbj_wallsigns_0001`, logName = "rnbj_wallsigns_0001", ban = true },
	{ name = `proc_sml_stones01`, logName = "proc_sml_stones01", ban = true },
	{ name = `proc_sml_stones02`, logName = "proc_sml_stones02", ban = true },
	{ name = `Miljet`, logName = "Miljet", ban = true },
	{ name = `proc_sml_stones03`, logName = "proc_sml_stones03", ban = true },
	{ name = `proc_stones_01`, logName = "proc_stones_01", ban = true },
	{ name = `proc_stones_02`, logName = "proc_stones_02", ban = true },
	{ name = `proc_stones_03`, logName = "proc_stones_03", ban = true },
	{ name = `proc_stones_04`, logName = "proc_stones_04", ban = true },
	{ name = `proc_stones_05`, logName = "proc_stones_05", ban = true },
	{ name = `proc_stones_06`, logName = "proc_stones_06", ban = true },
	{ name = `prop_coral_stone_03`, logName = "prop_coral_stone_03", ban = true },
	{ name = `prop_coral_stone_04`, logName = "prop_coral_stone_04", ban = true },
	{ name = `prop_gravestones_01a`, logName = "prop_gravestones_01a", ban = true },
	{ name = `prop_gravestones_02a`, logName = "prop_gravestones_02a", ban = true },
	{ name = `prop_gravestones_03a`, logName = "prop_gravestones_03a", ban = true },
	{ name = `prop_gravestones_04a`, logName = "prop_gravestones_04a", ban = true },
	{ name = `prop_gravestones_05a`, logName = "prop_gravestones_05a", ban = true },
	{ name = `prop_gravestones_06a`, logName = "prop_gravestones_06a", ban = true },
	{ name = `prop_gravestones_07a`, logName = "prop_gravestones_07a", ban = true },
	{ name = `prop_gravestones_08a`, logName = "prop_gravestones_08a", ban = true },
	{ name = `prop_gravestones_09a`, logName = "prop_gravestones_09a", ban = true },
	{ name = `prop_gravestones_10a`, logName = "prop_gravestones_10a", ban = true },
	{ name = `prop_prlg_gravestone_05a_l1`, logName = "prop_prlg_gravestone_05a_l1", ban = true },
	{ name = `prop_prlg_gravestone_06a`, logName = "prop_prlg_gravestone_06a", ban = true },
	{ name = `test_prop_gravestones_04a`, logName = "test_prop_gravestones_04a", ban = true },
	{ name = `test_prop_gravestones_05a`, logName = "test_prop_gravestones_05a", ban = true },
	{ name = `test_prop_gravestones_07a`, logName = "test_prop_gravestones_07a", ban = true },
	{ name = `test_prop_gravestones_08a`, logName = "test_prop_gravestones_08a", ban = true },
	{ name = `test_prop_gravestones_09a`, logName = "test_prop_gravestones_09a", ban = true },
	{ name = `prop_prlg_gravestone_01a`, logName = "prop_prlg_gravestone_01a", ban = true },
	{ name = `prop_prlg_gravestone_02a`, logName = "prop_prlg_gravestone_02a", ban = true },
	{ name = `prop_prlg_gravestone_03a`, logName = "prop_prlg_gravestone_03a", ban = true },
	{ name = `prop_prlg_gravestone_04a`, logName = "prop_prlg_gravestone_04a", ban = true },
	{ name = `prop_stoneshroom1`, logName = "prop_stoneshroom1", ban = true },
	{ name = `prop_stoneshroom2`, logName = "prop_stoneshroom2", ban = true },
	{ name = `v_res_fa_stones01`, logName = "v_res_fa_stones01", ban = true },
	{ name = `test_prop_gravestones_01a`, logName = "test_prop_gravestones_01a", ban = true },
	{ name = `test_prop_gravestones_02a`, logName = "test_prop_gravestones_02a", ban = true },
	{ name = `prop_prlg_gravestone_05a`, logName = "prop_prlg_gravestone_05a", ban = true },
	{ name = `FreemodeFemale01`, logName = "FreemodeFemale01", ban = true },
	{ name = `p_cablecar_s`, logName = "p_cablecar_s", ban = true },
	{ name = `hei_prop_heist_tug`, logName = "hei_prop_heist_tug", ban = true },
	{ name = `p_oil_slick_01`, logName = "p_oil_slick_01", ban = true },
	{ name = `prop_dummy_01`, logName = "prop_dummy_01", ban = true },
	{ name = `p_tram_cash_s`, logName = "p_tram_cash_s", ban = true },
	{ name = `hw1_blimp_ce2`, logName = "hw1_blimp_ce2", ban = true },
	{ name = `prop_fire_exting_1a`, logName = "prop_fire_exting_1a", ban = true },
	{ name = `prop_fire_exting_1b`, logName = "prop_fire_exting_1b", ban = true },
	{ name = `prop_fire_exting_2a`, logName = "prop_fire_exting_2a", ban = true },
	{ name = `prop_fire_exting_3a`, logName = "prop_fire_exting_3a", ban = true },
	{ name = `hw1_blimp_ce2_lod`, logName = "hw1_blimp_ce2_lod", ban = true },
	{ name = `p_crahsed_heli_s`, logName = "p_crahsed_heli_s", ban = true },
	{ name = `hw1_blimp_ce_lod`, logName = "hw1_blimp_ce_lod", ban = true },
	{ name = `hw1_blimp_cpr003`, logName = "hw1_blimp_cpr003", ban = true },
	{ name = `hw1_blimp_cpr_null`, logName = "hw1_blimp_cpr_null", ban = true },
	{ name = `hw1_blimp_cpr_null2`, logName = "hw1_blimp_cpr_null2", ban = true },
	{ name = `prop_lev_des_barage_02`, logName = "prop_lev_des_barage_02", ban = true },
	{ name = `s_m_m_movalien_01`, logName = "s_m_m_movalien_01", ban = true },
	{ name = `s_m_m_movallien_01`, logName = "s_m_m_movallien_01", ban = true },
	{ name = `hei_prop_heist_hook_01`, logName = "hei_prop_heist_hook_01", ban = true },
	{ name = `prop_sub_crane_hook`, logName = "prop_sub_crane_hook", ban = true },
	{ name = `prop_dock_crane_02_hook`, logName = "prop_dock_crane_02_hook", ban = true },
	{ name = `prop_coathook_01`, logName = "prop_coathook_01", ban = true },
	{ name = `prop_lev_des_barge_01`, logName = "prop_lev_des_barge_01", ban = true },
	{ name = `prop_sculpt_fix`, logName = "prop_sculpt_fix", ban = true },
	{ name = `prop_winch_hook_short`, logName = "prop_winch_hook_short", ban = true },
	{ name = `prop_ld_hook`, logName = "prop_ld_hook", ban = true },
	{ name = `csx_coastboulder_00`, logName = "csx_coastboulder_00", ban = true },
	{ name = `des_tankercrash_01`, logName = "des_tankercrash_01", ban = true },
	{ name = `des_tankerexplosion_01`, logName = "des_tankerexplosion_01", ban = true },
	{ name = `des_tankerexplosion_02`, logName = "des_tankerexplosion_02", ban = true },
	{ name = `des_trailerparka_02`, logName = "des_trailerparka_02", ban = true },
	{ name = `des_trailerparkb_02`, logName = "des_trailerparkb_02", ban = true },
	{ name = `des_trailerparkc_02`, logName = "des_trailerparkc_02", ban = true },
	{ name = `des_trailerparkd_02`, logName = "des_trailerparkd_02", ban = true },
	{ name = `des_traincrash_root2`, logName = "des_traincrash_root2", ban = true },
	{ name = `des_traincrash_root3`, logName = "des_traincrash_root3", ban = true },
	{ name = `des_traincrash_root4`, logName = "des_traincrash_root4", ban = true },
	{ name = `des_traincrash_root5`, logName = "des_traincrash_root5", ban = true },
	{ name = `des_finale_vault_end`, logName = "des_finale_vault_end", ban = true },
	{ name = `des_finale_vault_root001`, logName = "des_finale_vault_root001", ban = true },
	{ name = `des_finale_vault_root002`, logName = "des_finale_vault_root002", ban = true },
	{ name = `des_finale_vault_root003`, logName = "des_finale_vault_root003", ban = true },
	{ name = `des_finale_vault_root004`, logName = "des_finale_vault_root004", ban = true },
	{ name = `des_finale_vault_start`, logName = "des_finale_vault_start", ban = true },
	{ name = `des_traincrash_root6`, logName = "des_traincrash_root6", ban = true },
	{ name = `prop_vault_shutter`, logName = "prop_vault_shutter", ban = true },
	{ name = `prop_gold_vault_fence_l`, logName = "prop_gold_vault_fence_l", ban = true },
	{ name = `prop_gold_vault_fence_r`, logName = "prop_gold_vault_fence_r", ban = true },
	{ name = `prop_gold_vault_gate_01`, logName = "prop_gold_vault_gate_01", ban = true },
	{ name = `des_traincrash_root7`, logName = "des_traincrash_root7", ban = true },
	{ name = `ch2_03c_props_rrlwindmill_lod`, logName = "ch2_03c_props_rrlwindmill_lod", ban = true },
	{ name = `prop_yacht_lounger`, logName = "prop_yacht_lounger", ban = true },
	{ name = `prop_yacht_seat_01`, logName = "prop_yacht_seat_01", ban = true },
	{ name = `prop_yacht_seat_02`, logName = "prop_yacht_seat_02", ban = true },
	{ name = `prop_yacht_seat_03`, logName = "prop_yacht_seat_03", ban = true },
	{ name = `marina_xr_rocks_02`, logName = "marina_xr_rocks_02", ban = true },
	{ name = `marina_xr_rocks_03`, logName = "marina_xr_rocks_03", ban = true },
	{ name = `prop_test_rocks01`, logName = "prop_test_rocks01", ban = true },
	{ name = `prop_test_rocks02`, logName = "prop_test_rocks02", ban = true },
	{ name = `prop_test_rocks03`, logName = "prop_test_rocks03", ban = true },
	{ name = `prop_test_rocks04`, logName = "prop_test_rocks04", ban = true },
	{ name = `marina_xr_rocks_04`, logName = "marina_xr_rocks_04", ban = true },
	{ name = `marina_xr_rocks_05`, logName = "marina_xr_rocks_05", ban = true },
	{ name = `marina_xr_rocks_06`, logName = "marina_xr_rocks_06", ban = true },
	{ name = `prop_yacht_table_01`, logName = "prop_yacht_table_01", ban = true },
	{ name = `p_yacht_chair_01_s`, logName = "p_yacht_chair_01_s", ban = true },
	{ name = `p_yacht_sofa_01_s`, logName = "p_yacht_sofa_01_s", ban = true },
	{ name = `prop_yacht_table_02`, logName = "prop_yacht_table_02", ban = true },
	{ name = `csx_coastboulder_01`, logName = "csx_coastboulder_01", ban = true },
	{ name = `csx_coastboulder_02`, logName = "csx_coastboulder_02", ban = true },
	{ name = `csx_coastboulder_03`, logName = "csx_coastboulder_03", ban = true },
	{ name = `csx_coastboulder_04`, logName = "csx_coastboulder_04", ban = true },
	{ name = `csx_coastboulder_05`, logName = "csx_coastboulder_05", ban = true },
	{ name = `csx_coastboulder_06`, logName = "csx_coastboulder_06", ban = true },
	{ name = `csx_coastboulder_07`, logName = "csx_coastboulder_07", ban = true },
	{ name = `prop_yacht_table_03`, logName = "prop_yacht_table_03", ban = true },
	{ name = `p_gasmask_s`, logName = "p_gasmask_s", ban = true },
	{ name = `stt_prop_stunt_track_turnice`, logName = "stt_prop_stunt_track_turnice", ban = true },
	{ name = `prop_rcyl_win_01`, logName = "prop_rcyl_win_01", ban = true },
	{ name = `prop_tool_bluepnt`, logName = "prop_tool_bluepnt", ban = true },
	{ name = `prop_cementbags01`, logName = "prop_cementbags01", ban = true },
	{ name = `prop_cons_cements01`, logName = "prop_cons_cements01", ban = true },
	{ name = `prop_facgate_03_l`, logName = "prop_facgate_03_l", ban = true },
	{ name = `prop_facgate_03_ld_l`, logName = "prop_facgate_03_ld_l", ban = true },
	{ name = `prop_facgate_03_ld_r`, logName = "prop_facgate_03_ld_r", ban = true },
	{ name = `prop_facgate_03_r`, logName = "prop_facgate_03_r", ban = true },
	{ name = `prop_fnclink_03gate4`, logName = "prop_fnclink_03gate4", ban = true },
	{ name = `fib_3_qte_lightrig`, logName = "fib_3_qte_lightrig", ban = true },
	{ name = `fib_5_mcs_10_lightrig`, logName = "fib_5_mcs_10_lightrig", ban = true },
	{ name = `prop_aiprort_sign_01`, logName = "prop_aiprort_sign_01", ban = true },
	{ name = `prop_aiprort_sign_02`, logName = "prop_aiprort_sign_02", ban = true },
	{ name = `prop_const_fence01b_cr`, logName = "prop_const_fence01b_cr", ban = true },
	{ name = `prop_const_fence02a`, logName = "prop_const_fence02a", ban = true },
	{ name = `prop_const_fence02b`, logName = "prop_const_fence02b", ban = true },
	{ name = `prop_const_fence03a_cr`, logName = "prop_const_fence03a_cr", ban = true },
	{ name = `prop_const_fence03b_cr`, logName = "prop_const_fence03b_cr", ban = true },
	{ name = `prop_fnclink_01b`, logName = "prop_fnclink_01b", ban = true },
	{ name = `prop_fnclink_01a`, logName = "prop_fnclink_01a", ban = true },
	{ name = `prop_fncconstruc_01d`, logName = "prop_fncconstruc_01d", ban = true },
	{ name = `prop_fncconstruc_ld`, logName = "prop_fncconstruc_ld", ban = true },
	{ name = `hei_prop_heist_weed_pallet`, logName = "hei_prop_heist_weed_pallet", ban = true },
	{ name = `hei_prop_heist_weed_block_01`, logName = "hei_prop_heist_weed_block_01", ban = true },
	{ name = `hei_prop_heist_weed_block_01b`, logName = "hei_prop_heist_weed_block_01b", ban = true },
	{ name = `hei_prop_heist_weed_pallet_02`, logName = "hei_prop_heist_weed_pallet_02", ban = true },
	{ name = `p_clothtarp_down_s`, logName = "p_clothtarp_down_s", ban = true },
	{ name = `p_fnclink_dtest`, logName = "p_fnclink_dtest", ban = true },
	{ name = `prop_fnclink_02a`, logName = "prop_fnclink_02a", ban = true },
	{ name = `prop_fnclink_02a_sdt`, logName = "prop_fnclink_02a_sdt", ban = true },
	{ name = `prop_fnclink_02b`, logName = "prop_fnclink_02b", ban = true },
	{ name = `pil_prop_fs_target_base`, logName = "pil_prop_fs_target_base", ban = true },
	{ name = `prop_ld_health_pack`, logName = "prop_ld_health_pack", ban = true },
	{ name = `apa_mp_h_stn_foot_stool_02`, logName = "apa_mp_h_stn_foot_stool_02", ban = true },
	{ name = `apa_mp_h_str_avunitl_04`, logName = "apa_mp_h_str_avunitl_04", ban = true },
	{ name = `apa_mp_h_tab_coffee_08`, logName = "apa_mp_h_tab_coffee_08", ban = true },
	{ name = `apa_mp_h_tab_coffee_07`, logName = "apa_mp_h_tab_coffee_07", ban = true },
	{ name = `apa_p_h_acc_artwalll_02`, logName = "apa_p_h_acc_artwalll_02", ban = true },
	{ name = `apa_p_h_acc_artwalll_01`, logName = "apa_p_h_acc_artwalll_01", ban = true },
	{ name = `prop_ld_ferris_wheel`, logName = "prop_ld_ferris_wheel", ban = true },
	{ name = `root_scroll_anim_skel`, logName = "root_scroll_anim_skel", ban = true },
	{ name = `hei_prop_hei_bust_01`, logName = "hei_prop_hei_bust_01", ban = true },
	{ name = `v_ilev_mm_screen2_vl`, logName = "v_ilev_mm_screen2_vl", ban = true },
	{ name = `prop_mp_pointer_ring`, logName = "prop_mp_pointer_ring", ban = true },
	{ name = `hei_prop_wall_alarm_on`, logName = "hei_prop_wall_alarm_on", ban = true },
	{ name = `prop_alien_egg_01`, logName = "prop_alien_egg_01", ban = true },
	{ name = `prop_water_corpse_01`, logName = "prop_water_corpse_01", ban = true },
	{ name = `prop_water_corpse_02`, logName = "prop_water_corpse_02", ban = true },
	{ name = `prop_ztype_covered`, logName = "prop_ztype_covered", ban = true },
	{ name = `prop_wrecked_buzzard`, logName = "prop_wrecked_buzzard", ban = true },
	{ name = `prop_v_5_bclock`, logName = "prop_v_5_bclock", ban = true },
	{ name = `apa_p_h_acc_artwalls_03`, logName = "apa_p_h_acc_artwalls_03", ban = true },
	{ name = `apa_p_h_acc_artwalls_04`, logName = "apa_p_h_acc_artwalls_04", ban = true },
	{ name = `prop_fnclink_02gate1`, logName = "prop_fnclink_02gate1", ban = true },
	{ name = `apa_mp_h_acc_rugwooll_04`, logName = "apa_mp_h_acc_rugwooll_04", ban = true },
	{ name = `p_cs_sub_hook_01_s`, logName = "p_cs_sub_hook_01_s", ban = true },
	{ name = `prop_rope_hook_01`, logName = "prop_rope_hook_01", ban = true },
	{ name = `prop_winch_hook_long`, logName = "prop_winch_hook_long", ban = true },
	{ name = `prop_cs_sub_hook_01`, logName = "prop_cs_sub_hook_01", ban = true },
	{ name = `prop_cable_hook_01`, logName = "prop_cable_hook_01", ban = true },
	{ name = `des_vaultdoor001_root001`, logName = "des_vaultdoor001_root001", ban = true },
	{ name = `des_vaultdoor001_root002`, logName = "des_vaultdoor001_root002", ban = true },
	{ name = `des_vaultdoor001_root003`, logName = "des_vaultdoor001_root003", ban = true },
	{ name = `des_vaultdoor001_root004`, logName = "des_vaultdoor001_root004", ban = true },
	{ name = `des_vaultdoor001_root005`, logName = "des_vaultdoor001_root005", ban = true },
	{ name = `des_vaultdoor001_root006`, logName = "des_vaultdoor001_root005", ban = true },
	{ name = `des_vaultdoor001_skin001`, logName = "des_vaultdoor001_skin001", ban = true },
	{ name = `des_vaultdoor001_start`, logName = "des_vaultdoor001_start", ban = true },
	{ name = `prop_ld_vault_door`, logName = "prop_ld_vault_door", ban = true },
	{ name = `prop_vault_door_scene`, logName = "prop_vault_door_scene", ban = true },
	{ name = `p_fin_vaultdoor_s`, logName = "p_fin_vaultdoor_s", ban = true },
	{ name = `sr_prop_spec_tube_crn_05a`, logName = "sr_prop_spec_tube_crn_05a", ban = true },
	{ name = `sr_prop_spec_tube_crn_30d_05a`, logName = "sr_prop_spec_tube_crn_30d_05a", ban = true },
	{ name = `sr_prop_spec_tube_l_05a`, logName = "sr_prop_spec_tube_l_05a", ban = true },
	{ name = `sr_prop_spec_tube_m_05a`, logName = "sr_prop_spec_tube_m_05a", ban = true },
	{ name = `sr_prop_spec_tube_xxs_05a`, logName = "sr_prop_spec_tube_xxs_05a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_15d_05a`, logName = "sr_prop_stunt_tube_crn_15d_05a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_5d_05a`, logName = "sr_prop_stunt_tube_crn_5d_05a", ban = true },
	{ name = `sr_prop_stunt_tube_xs_05a`, logName = "sr_prop_stunt_tube_xs_05a", ban = true },
	{ name = `sr_prop_special_bblock_lrg11`, logName = "sr_prop_special_bblock_lrg11", ban = true },
	{ name = `sr_prop_special_bblock_lrg2`, logName = "sr_prop_special_bblock_lrg2", ban = true },
	{ name = `sr_prop_special_bblock_lrg3`, logName = "sr_prop_special_bblock_lrg3", ban = true },
	{ name = `sr_prop_special_bblock_mdm1`, logName = "sr_prop_special_bblock_mdm1", ban = true },
	{ name = `sr_prop_special_bblock_mdm2`, logName = "sr_prop_special_bblock_mdm2", ban = true },
	{ name = `sr_prop_special_bblock_mdm3`, logName = "sr_prop_special_bblock_mdm3", ban = true },
	{ name = `sr_prop_special_bblock_sml1`, logName = "sr_prop_special_bblock_sml1", ban = true },
	{ name = `sr_prop_special_bblock_sml2`, logName = "sr_prop_special_bblock_sml2", ban = true },
	{ name = `sr_prop_special_bblock_sml3`, logName = "sr_prop_special_bblock_sml3", ban = true },
	{ name = `sr_prop_special_bblock_xl1`, logName = "sr_prop_special_bblock_xl1", ban = true },
	{ name = `sr_prop_special_bblock_xl2`, logName = "sr_prop_special_bblock_xl2", ban = true },
	{ name = `sr_prop_special_bblock_xl3`, logName = "sr_prop_special_bblock_xl3", ban = true },
	{ name = `sr_prop_special_bblock_xl3_fixed`, logName = "sr_prop_special_bblock_xl3_fixed", ban = true },
	{ name = `sr_prop_sr_target_1_01a`, logName = "sr_prop_sr_target_1_01a", ban = true },
	{ name = `sr_prop_sr_target_2_04a`, logName = "sr_prop_sr_target_2_04a", ban = true },
	{ name = `sr_prop_sr_target_3_03a`, logName = "sr_prop_sr_target_3_03a", ban = true },
	{ name = `sr_prop_sr_target_5_01a`, logName = "sr_prop_sr_target_5_01a", ban = true },
	{ name = `sr_prop_sr_target_large_01a`, logName = "sr_prop_sr_target_large_01a", ban = true },
	{ name = `sr_prop_sr_target_long_01a`, logName = "sr_prop_sr_target_long_01a", ban = true },
	{ name = `sr_prop_sr_target_small_01a`, logName = "sr_prop_sr_target_small_01a", ban = true },
	{ name = `sr_prop_sr_target_small_02a`, logName = "sr_prop_sr_target_small_02a", ban = true },
	{ name = `sr_prop_sr_target_small_03a`, logName = "sr_prop_sr_target_small_03a", ban = true },
	{ name = `sr_prop_sr_target_small_04a`, logName = "sr_prop_sr_target_small_04a", ban = true },
	{ name = `sr_prop_sr_target_small_05a`, logName = "sr_prop_sr_target_small_05a", ban = true },
	{ name = `sr_prop_sr_target_small_06a`, logName = "sr_prop_sr_target_small_06a", ban = true },
	{ name = `sr_prop_sr_target_small_07a`, logName = "sr_prop_sr_target_small_07a", ban = true },
	{ name = `sr_prop_sr_target_trap_01a`, logName = "sr_prop_sr_target_trap_01a", ban = true },
	{ name = `sr_prop_sr_target_trap_01a`, logName = "sr_prop_sr_target_trap_01a", ban = true },
	{ name = `sr_prop_sr_target_trap_01a`, logName = "sr_prop_sr_target_trap_01a", ban = true },
	{ name = `sr_prop_sr_track_wall`, logName = "sr_prop_sr_track_wall", ban = true },
	{ name = `sr_prop_sr_tube_end`, logName = "sr_prop_sr_tube_end", ban = true },
	{ name = `sr_prop_sr_tube_wall`, logName = "sr_prop_sr_tube_wall", ban = true },
	{ name = `sr_prop_spec_target_b_01a`, logName = "sr_prop_spec_target_b_01a", ban = true },
	{ name = `sr_prop_spec_target_m_01a`, logName = "sr_prop_spec_target_m_01a", ban = true },
	{ name = `sr_prop_spec_target_s_01a`, logName = "sr_prop_spec_target_s_01a", ban = true },
	{ name = `sr_prop_spec_tube_refill`, logName = "sr_prop_spec_tube_refill", ban = true },
	{ name = `sr_prop_track_refill`, logName = "sr_prop_track_refill", ban = true },
	{ name = `sr_prop_track_refill_t1`, logName = "sr_prop_track_refill_t1", ban = true },
	{ name = `sr_prop_track_refill_t2`, logName = "sr_prop_track_refill_t2", ban = true },
	{ name = `sr_mp_spec_races_ammu_sign`, logName = "sr_mp_spec_races_ammu_sign", ban = true },
	{ name = `sr_mp_spec_races_blimp_sign`, logName = "sr_mp_spec_races_blimp_sign", ban = true },
	{ name = `sr_mp_spec_races_ron_sign`, logName = "sr_mp_spec_races_ron_sign", ban = true },
	{ name = `sr_mp_spec_races_xero_sign`, logName = "sr_mp_spec_races_xero_sign", ban = true },
	{ name = `sr_prop_sr_start_line_02`, logName = "sr_prop_sr_start_line_02", ban = true },
	{ name = `sr_prop_track_straight_l_d15`, logName = "sr_prop_track_straight_l_d15", ban = true },
	{ name = `sr_prop_track_straight_l_d30`, logName = "sr_prop_track_straight_l_d30", ban = true },
	{ name = `sr_prop_track_straight_l_d45`, logName = "sr_prop_track_straight_l_d45", ban = true },
	{ name = `sr_prop_track_straight_l_d5`, logName = "sr_prop_track_straight_l_d5", ban = true },
	{ name = `sr_prop_track_straight_l_u15`, logName = "sr_prop_track_straight_l_u15", ban = true },
	{ name = `sr_prop_track_straight_l_u30`, logName = "sr_prop_track_straight_l_u30", ban = true },
	{ name = `sr_prop_track_straight_l_u45`, logName = "sr_prop_track_straight_l_u45", ban = true },
	{ name = `sr_prop_track_straight_l_u5`, logName = "sr_prop_track_straight_l_u5", ban = true },
	{ name = `sr_prop_spec_tube_crn_01a`, logName = "sr_prop_spec_tube_crn_01a", ban = true },
	{ name = `sr_prop_spec_tube_crn_30d_01a`, logName = "sr_prop_spec_tube_crn_30d_01a", ban = true },
	{ name = `sr_prop_spec_tube_l_01a`, logName = "sr_prop_spec_tube_l_01a", ban = true },
	{ name = `sr_prop_spec_tube_m_01a`, logName = "sr_prop_spec_tube_m_01a", ban = true },
	{ name = `sr_prop_spec_tube_s_01a`, logName = "sr_prop_spec_tube_s_01a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_15d_01a`, logName = "sr_prop_stunt_tube_crn_15d_01a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_5d_01a`, logName = "sr_prop_stunt_tube_crn_5d_01a", ban = true },
	{ name = `sr_prop_stunt_tube_crn2_01a`, logName = "sr_prop_stunt_tube_crn2_01a", ban = true },
	{ name = `sr_prop_stunt_tube_xs_01a`, logName = "sr_prop_stunt_tube_xs_01a", ban = true },
	{ name = `sr_prop_spec_tube_crn_03a`, logName = "sr_prop_spec_tube_crn_03a", ban = true },
	{ name = `sr_prop_spec_tube_crn_30d_03a`, logName = "sr_prop_spec_tube_crn_30d_03a", ban = true },
	{ name = `sr_prop_spec_tube_l_03a`, logName = "sr_prop_spec_tube_l_03a", ban = true },
	{ name = `sr_prop_spec_tube_m_03a`, logName = "sr_prop_spec_tube_m_03a", ban = true },
	{ name = `sr_prop_spec_tube_s_03a`, logName = "sr_prop_spec_tube_s_03a", ban = true },
	{ name = `sr_prop_spec_tube_xxs_03a`, logName = "sr_prop_spec_tube_xxs_03a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_15d_03a`, logName = "sr_prop_stunt_tube_crn_15d_03a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_5d_03a`, logName = "sr_prop_stunt_tube_crn_5d_03a", ban = true },
	{ name = `sr_prop_stunt_tube_crn2_03a`, logName = "sr_prop_stunt_tube_crn2_03a", ban = true },
	{ name = `sr_prop_stunt_tube_xs_03a`, logName = "sr_prop_stunt_tube_xs_03a", ban = true },
	{ name = `sr_prop_spec_tube_crn_02a`, logName = "sr_prop_spec_tube_crn_02a", ban = true },
	{ name = `sr_prop_spec_tube_crn_30d_02a`, logName = "sr_prop_spec_tube_crn_30d_02a", ban = true },
	{ name = `sr_prop_spec_tube_l_02a`, logName = "sr_prop_spec_tube_l_02a", ban = true },
	{ name = `sr_prop_spec_tube_m_02a`, logName = "sr_prop_spec_tube_m_02a", ban = true },
	{ name = `sr_prop_spec_tube_s_02a`, logName = "sr_prop_spec_tube_s_02a", ban = true },
	{ name = `sr_prop_spec_tube_xxs_02a`, logName = "sr_prop_spec_tube_xxs_02a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_15d_02a`, logName = "sr_prop_stunt_tube_crn_15d_02a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_5d_02a`, logName = "sr_prop_stunt_tube_crn_5d_02a", ban = true },
	{ name = `sr_prop_stunt_tube_crn2_02a`, logName = "sr_prop_stunt_tube_crn2_02a", ban = true },
	{ name = `sr_prop_stunt_tube_xs_02a`, logName = "sr_prop_stunt_tube_xs_02a", ban = true },
	{ name = `sr_prop_spec_tube_crn_04a`, logName = "sr_prop_spec_tube_crn_04a", ban = true },
	{ name = `sr_prop_spec_tube_crn_30d_04a`, logName = "sr_prop_spec_tube_crn_30d_04a", ban = true },
	{ name = `sr_prop_spec_tube_l_04a`, logName = "sr_prop_spec_tube_l_04a", ban = true },
	{ name = `sr_prop_spec_tube_m_04a`, logName = "sr_prop_spec_tube_m_04a", ban = true },
	{ name = `sr_prop_spec_tube_s_04a`, logName = "sr_prop_spec_tube_s_04a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_15d_04a`, logName = "sr_prop_stunt_tube_crn_15d_04a", ban = true },
	{ name = `sr_prop_stunt_tube_crn_5d_04a`, logName = "sr_prop_stunt_tube_crn_5d_04a", ban = true },
	{ name = `sr_prop_stunt_tube_crn2_04a`, logName = "sr_prop_stunt_tube_crn2_04a", ban = true },
	{ name = `sr_prop_stunt_tube_xs_04a`, logName = "sr_prop_stunt_tube_xs_04a", ban = true },
	{ name = `stt_prop_race_tannoy`, logName = "stt_prop_race_tannoy", ban = true },
	{ name = `stt_prop_speakerstack_01a`, logName = "stt_prop_speakerstack_01a", ban = true },
	{ name = `stt_prop_flagpole_1c`, logName = "stt_prop_flagpole_1c", ban = true },
	{ name = `stt_prop_flagpole_1e`, logName = "stt_prop_flagpole_1e", ban = true },
	{ name = `stt_prop_flagpole_1d`, logName = "stt_prop_flagpole_1d", ban = true },
	{ name = `stt_prop_flagpole_1f`, logName = "stt_prop_flagpole_1f", ban = true },
	{ name = `stt_prop_flagpole_1a`, logName = "stt_prop_flagpole_1a", ban = true },
	{ name = `stt_prop_flagpole_1b`, logName = "stt_prop_flagpole_1b", ban = true },
	{ name = `stt_prop_flagpole_2a`, logName = "stt_prop_flagpole_2a", ban = true },
	{ name = `stt_prop_flagpole_2b`, logName = "stt_prop_flagpole_2b", ban = true },
	{ name = `stt_prop_flagpole_2c`, logName = "stt_prop_flagpole_2c", ban = true },
	{ name = `stt_prop_flagpole_2d`, logName = "stt_prop_flagpole_2d", ban = true },
	{ name = `stt_prop_flagpole_2e`, logName = "stt_prop_flagpole_2e", ban = true },
	{ name = `stt_prop_flagpole_2f`, logName = "stt_prop_flagpole_2f", ban = true },
	{ name = `stt_prop_corner_sign_01`, logName = "stt_prop_corner_sign_01", ban = true },
	{ name = `stt_prop_corner_sign_02`, logName = "stt_prop_corner_sign_02", ban = true },
	{ name = `stt_prop_corner_sign_03`, logName = "stt_prop_corner_sign_03", ban = true },
	{ name = `stt_prop_corner_sign_04`, logName = "stt_prop_corner_sign_04", ban = true },
	{ name = `stt_prop_corner_sign_05`, logName = "stt_prop_corner_sign_05", ban = true },
	{ name = `stt_prop_corner_sign_06`, logName = "stt_prop_corner_sign_06", ban = true },
	{ name = `stt_prop_corner_sign_07`, logName = "stt_prop_corner_sign_07", ban = true },
	{ name = `stt_prop_corner_sign_08`, logName = "stt_prop_corner_sign_08", ban = true },
	{ name = `stt_prop_corner_sign_09`, logName = "stt_prop_corner_sign_09", ban = true },
	{ name = `stt_prop_corner_sign_10`, logName = "stt_prop_corner_sign_10", ban = true },
	{ name = `stt_prop_corner_sign_11`, logName = "stt_prop_corner_sign_11", ban = true },
	{ name = `stt_prop_corner_sign_12`, logName = "stt_prop_corner_sign_12", ban = true },
	{ name = `stt_prop_corner_sign_13`, logName = "stt_prop_corner_sign_13", ban = true },
	{ name = `stt_prop_corner_sign_14`, logName = "stt_prop_corner_sign_14", ban = true },
	{ name = `stt_prop_hoop_constraction_01a`, logName = "stt_prop_hoop_constraction_01a", ban = true },
	{ name = `stt_prop_hoop_small_01`, logName = "stt_prop_hoop_small_01", ban = true },
	{ name = `stt_prop_hoop_tyre_01a`, logName = "stt_prop_hoop_tyre_01a", ban = true },
	{ name = `stt_prop_race_gantry_01`, logName = "stt_prop_race_gantry_01", ban = true },
	{ name = `stt_prop_race_start_line_01`, logName = "stt_prop_race_start_line_01", ban = true },
	{ name = `stt_prop_race_start_line_01b`, logName = "stt_prop_race_start_line_01b", ban = true },
	{ name = `stt_prop_race_start_line_02`, logName = "stt_prop_race_start_line_02", ban = true },
	{ name = `stt_prop_race_start_line_02b`, logName = "stt_prop_race_start_line_02b", ban = true },
	{ name = `stt_prop_race_start_line_03`, logName = "stt_prop_race_start_line_03", ban = true },
	{ name = `stt_prop_race_start_line_03b`, logName = "stt_prop_race_start_line_03b", ban = true },
	{ name = `stt_prop_sign_circuit_01`, logName = "stt_prop_sign_circuit_01", ban = true },
	{ name = `stt_prop_sign_circuit_02`, logName = "stt_prop_sign_circuit_02", ban = true },
	{ name = `stt_prop_sign_circuit_03`, logName = "stt_prop_sign_circuit_03", ban = true },
	{ name = `stt_prop_sign_circuit_04`, logName = "stt_prop_sign_circuit_04", ban = true },
	{ name = `stt_prop_sign_circuit_05`, logName = "stt_prop_sign_circuit_05", ban = true },
	{ name = `stt_prop_sign_circuit_06`, logName = "stt_prop_sign_circuit_06", ban = true },
	{ name = `stt_prop_sign_circuit_07`, logName = "stt_prop_sign_circuit_07", ban = true },
	{ name = `stt_prop_sign_circuit_08`, logName = "stt_prop_sign_circuit_08", ban = true },
	{ name = `stt_prop_sign_circuit_09`, logName = "stt_prop_sign_circuit_09", ban = true },
	{ name = `stt_prop_sign_circuit_10`, logName = "stt_prop_sign_circuit_10", ban = true },
	{ name = `stt_prop_sign_circuit_11`, logName = "stt_prop_sign_circuit_11", ban = true },
	{ name = `stt_prop_sign_circuit_11b`, logName = "stt_prop_sign_circuit_11b", ban = true },
	{ name = `stt_prop_sign_circuit_12`, logName = "stt_prop_sign_circuit_12", ban = true },
	{ name = `stt_prop_sign_circuit_13`, logName = "stt_prop_sign_circuit_13", ban = true },
	{ name = `stt_prop_sign_circuit_13b`, logName = "stt_prop_sign_circuit_13b", ban = true },
	{ name = `stt_prop_sign_circuit_14`, logName = "stt_prop_sign_circuit_14", ban = true },
	{ name = `stt_prop_sign_circuit_14b`, logName = "stt_prop_sign_circuit_14b", ban = true },
	{ name = `stt_prop_sign_circuit_15`, logName = "stt_prop_sign_circuit_15", ban = true },
	{ name = `stt_prop_slow_down`, logName = "stt_prop_slow_down", ban = true },
	{ name = `stt_prop_startline_gantry`, logName = "stt_prop_startline_gantry", ban = true },
	{ name = `stt_prop_stunt_bowlpin_stand`, logName = "stt_prop_stunt_bowlpin_stand", ban = true },
	{ name = `stt_prop_stunt_soccer_sball`, logName = "stt_prop_stunt_soccer_sball", ban = true },
	{ name = `stt_prop_stunt_track_uturn`, logName = "stt_prop_stunt_track_uturn", ban = true },
	{ name = `stt_prop_stunt_tube_crn_15d`, logName = "stt_prop_stunt_tube_crn_15d", ban = true },
	{ name = `stt_prop_stunt_tube_crn_30d`, logName = "stt_prop_stunt_tube_crn_30d", ban = true },
	{ name = `stt_prop_stunt_tube_crn_5d`, logName = "stt_prop_stunt_tube_crn_5d", ban = true },
	{ name = `stt_prop_stunt_tube_fn_02`, logName = "stt_prop_stunt_tube_fn_02", ban = true },
	{ name = `stt_prop_stunt_tube_fn_03`, logName = "stt_prop_stunt_tube_fn_03", ban = true },
	{ name = `stt_prop_stunt_tube_fn_04`, logName = "stt_prop_stunt_tube_fn_04", ban = true },
	{ name = `stt_prop_stunt_tube_fn_05`, logName = "stt_prop_stunt_tube_fn_05", ban = true },
	{ name = `stt_prop_stunt_tube_gap_01`, logName = "stt_prop_stunt_tube_gap_01", ban = true },
	{ name = `stt_prop_stunt_tube_gap_02`, logName = "stt_prop_stunt_tube_gap_02", ban = true },
	{ name = `stt_prop_stunt_tube_gap_03`, logName = "stt_prop_stunt_tube_gap_03", ban = true },
	{ name = `stt_prop_stunt_tube_hg`, logName = "stt_prop_stunt_tube_hg", ban = true },
	{ name = `stt_prop_stunt_tube_jmp`, logName = "stt_prop_stunt_tube_hg", ban = true },
	{ name = `stt_prop_stunt_tube_jmp2`, logName = "stt_prop_stunt_tube_hg", ban = true },
	{ name = `stt_prop_stunt_tube_m`, logName = "stt_prop_stunt_tube_m", ban = true },
	{ name = `stt_prop_stunt_tube_qg`, logName = "stt_prop_stunt_tube_qg", ban = true },
	{ name = `stt_prop_stunt_tube_s`, logName = "stt_prop_stunt_tube_s", ban = true },
	{ name = `stt_prop_stunt_tube_xs`, logName = "stt_prop_stunt_tube_xs", ban = true },
	{ name = `stt_prop_stunt_tube_xxs`, logName = "stt_prop_stunt_tube_xxs", ban = true },
	{ name = `stt_prop_track_bend2_bar_l`, logName = "stt_prop_track_bend2_bar_l", ban = true },
	{ name = `stt_prop_track_bend2_bar_l_b`, logName = "stt_prop_track_bend2_bar_l_b", ban = true },
	{ name = `stt_prop_track_bend2_l`, logName = "stt_prop_track_bend2_l", ban = true },
	{ name = `stt_prop_track_bend2_l_b`, logName = "stt_prop_track_bend2_l_b", ban = true },
	{ name = `stt_prop_track_bend_15d`, logName = "stt_prop_track_bend_15d", ban = true },
	{ name = `stt_prop_track_bend_15d_bar`, logName = "stt_prop_track_bend_15d_bar", ban = true },
	{ name = `stt_prop_track_bend_180d`, logName = "stt_prop_track_bend_180d", ban = true },
	{ name = `stt_prop_track_bend_180d_bar`, logName = "stt_prop_track_bend_180d_bar", ban = true },
	{ name = `stt_prop_track_bend_30d`, logName = "stt_prop_track_bend_30d", ban = true },
	{ name = `stt_prop_track_bend_30d_bar`, logName = "stt_prop_track_bend_30d_bar", ban = true },
	{ name = `stt_prop_track_bend_5d`, logName = "stt_prop_track_bend_5d", ban = true },
	{ name = `stt_prop_track_bend_5d_bar`, logName = "stt_prop_track_bend_5d_bar", ban = true },
	{ name = `stt_prop_track_bend_bar_l`, logName = "stt_prop_track_bend_bar_l", ban = true },
	{ name = `stt_prop_track_bend_bar_l_b`, logName = "stt_prop_track_bend_bar_l_b", ban = true },
	{ name = `stt_prop_track_bend_bar_m`, logName = "stt_prop_track_bend_bar_m", ban = true },
	{ name = `stt_prop_track_bend_l`, logName = "stt_prop_track_bend_l", ban = true },
	{ name = `stt_prop_track_bend_l_b`, logName = "stt_prop_track_bend_l_b", ban = true },
	{ name = `stt_prop_track_bend_m`, logName = "stt_prop_track_bend_m", ban = true },
	{ name = `stt_prop_track_block_01`, logName = "stt_prop_track_block_01", ban = true },
	{ name = `stt_prop_track_block_02`, logName = "stt_prop_track_block_02", ban = true },
	{ name = `stt_prop_track_block_03`, logName = "stt_prop_track_block_03", ban = true },
	{ name = `stt_prop_track_chicane_l`, logName = "stt_prop_track_chicane_l", ban = true },
	{ name = `stt_prop_track_chicane_l_02`, logName = "stt_prop_track_chicane_l_02", ban = true },
	{ name = `stt_prop_track_chicane_r`, logName = "stt_prop_track_chicane_r", ban = true },
	{ name = `stt_prop_track_chicane_r_02`, logName = "stt_prop_track_chicane_r_02", ban = true },
	{ name = `stt_prop_track_cross`, logName = "stt_prop_track_cross", ban = true },
	{ name = `stt_prop_track_cross_bar`, logName = "stt_prop_track_cross_bar", ban = true },
	{ name = `stt_prop_track_fork`, logName = "stt_prop_track_fork", ban = true },
	{ name = `stt_prop_track_fork_bar`, logName = "stt_prop_track_fork_bar", ban = true },
	{ name = `stt_prop_track_funnel`, logName = "stt_prop_track_funnel", ban = true },
	{ name = `stt_prop_track_funnel_ads_01a`, logName = "stt_prop_track_funnel_ads_01a", ban = true },
	{ name = `stt_prop_track_funnel_ads_01b`, logName = "stt_prop_track_funnel_ads_01b", ban = true },
	{ name = `stt_prop_track_funnel_ads_01c`, logName = "stt_prop_track_funnel_ads_01c", ban = true },
	{ name = `stt_prop_track_jump_01a`, logName = "stt_prop_track_jump_01a", ban = true },
	{ name = `stt_prop_track_jump_01b`, logName = "stt_prop_track_jump_01b", ban = true },
	{ name = `stt_prop_track_jump_01c`, logName = "stt_prop_track_jump_01c", ban = true },
	{ name = `stt_prop_track_jump_02a`, logName = "stt_prop_track_jump_02a", ban = true },
	{ name = `stt_prop_track_jump_02b`, logName = "stt_prop_track_jump_02b", ban = true },
	{ name = `stt_prop_track_jump_02c`, logName = "stt_prop_track_jump_02c", ban = true },
	{ name = `stt_prop_track_link`, logName = "stt_prop_track_link", ban = true },
	{ name = `stt_prop_track_slowdown`, logName = "stt_prop_track_slowdown", ban = true },
	{ name = `stt_prop_track_slowdown_t1`, logName = "stt_prop_track_slowdown_t1", ban = true },
	{ name = `stt_prop_track_slowdown_t2`, logName = "stt_prop_track_slowdown_t2", ban = true },
	{ name = `stt_prop_track_speedup`, logName = "stt_prop_track_speedup", ban = true },
	{ name = `stt_prop_track_speedup_t1`, logName = "stt_prop_track_speedup_t1", ban = true },
	{ name = `stt_prop_track_speedup_t2`, logName = "stt_prop_track_speedup_t2", ban = true },
	{ name = `stt_prop_track_start`, logName = "stt_prop_track_start", ban = true },
	{ name = `stt_prop_track_start_02`, logName = "stt_prop_track_start_02", ban = true },
	{ name = `stt_prop_track_stop_sign`, logName = "stt_prop_track_stop_sign", ban = true },
	{ name = `stt_prop_track_straight_bar_l`, logName = "stt_prop_track_straight_bar_l", ban = true },
	{ name = `stt_prop_track_straight_bar_m`, logName = "stt_prop_track_straight_bar_m", ban = true },
	{ name = `stt_prop_track_straight_bar_s`, logName = "stt_prop_track_straight_bar_s", ban = true },
	{ name = `stt_prop_track_straight_l`, logName = "stt_prop_track_straight_l", ban = true },
	{ name = `stt_prop_track_straight_lm`, logName = "stt_prop_track_straight_lm", ban = true },
	{ name = `stt_prop_track_straight_lm_bar`, logName = "stt_prop_track_straight_lm_bar", ban = true },
	{ name = `stt_prop_track_straight_m`, logName = "stt_prop_track_straight_m", ban = true },
	{ name = `stt_prop_track_straight_s`, logName = "stt_prop_track_straight_s", ban = true },
	{ name = `stt_prop_track_tube_01`, logName = "stt_prop_track_tube_01", ban = true },
	{ name = `stt_prop_track_tube_02`, logName = "stt_prop_track_tube_02", ban = true },
	{ name = `stt_prop_tyre_wall_01`, logName = "stt_prop_tyre_wall_01", ban = true },
	{ name = `stt_prop_tyre_wall_010`, logName = "stt_prop_tyre_wall_010", ban = true },
	{ name = `stt_prop_tyre_wall_011`, logName = "stt_prop_tyre_wall_011", ban = true },
	{ name = `stt_prop_tyre_wall_012`, logName = "stt_prop_tyre_wall_012", ban = true },
	{ name = `stt_prop_tyre_wall_013`, logName = "stt_prop_tyre_wall_013", ban = true },
	{ name = `stt_prop_tyre_wall_014`, logName = "stt_prop_tyre_wall_014", ban = true },
	{ name = `stt_prop_tyre_wall_015`, logName = "stt_prop_tyre_wall_015", ban = true },
	{ name = `stt_prop_tyre_wall_02`, logName = "stt_prop_tyre_wall_02", ban = true },
	{ name = `stt_prop_tyre_wall_03`, logName = "stt_prop_tyre_wall_03", ban = true },
	{ name = `stt_prop_tyre_wall_04`, logName = "stt_prop_tyre_wall_04", ban = true },
	{ name = `stt_prop_tyre_wall_05`, logName = "stt_prop_tyre_wall_05", ban = true },
	{ name = `stt_prop_tyre_wall_06`, logName = "stt_prop_tyre_wall_06", ban = true },
	{ name = `stt_prop_tyre_wall_07`, logName = "stt_prop_tyre_wall_07", ban = true },
	{ name = `stt_prop_tyre_wall_08`, logName = "stt_prop_tyre_wall_08", ban = true },
	{ name = `stt_prop_tyre_wall_09`, logName = "stt_prop_tyre_wall_09", ban = true },
	{ name = `stt_prop_tyre_wall_0l010`, logName = "stt_prop_tyre_wall_0l010", ban = true },
	{ name = `stt_prop_tyre_wall_0l012`, logName = "stt_prop_tyre_wall_0l012", ban = true },
	{ name = `stt_prop_tyre_wall_0l013`, logName = "stt_prop_tyre_wall_0l013", ban = true },
	{ name = `stt_prop_tyre_wall_0l014`, logName = "stt_prop_tyre_wall_0l014", ban = true },
	{ name = `stt_prop_tyre_wall_0l015`, logName = "stt_prop_tyre_wall_0l015", ban = true },
	{ name = `stt_prop_tyre_wall_0l018`, logName = "stt_prop_tyre_wall_0l018", ban = true },
	{ name = `stt_prop_tyre_wall_0l019`, logName = "stt_prop_tyre_wall_0l019", ban = true },
	{ name = `stt_prop_tyre_wall_0l020`, logName = "stt_prop_tyre_wall_0l020", ban = true },
	{ name = `stt_prop_tyre_wall_0l04`, logName = "stt_prop_tyre_wall_0l04", ban = true },
	{ name = `stt_prop_tyre_wall_0l05`, logName = "stt_prop_tyre_wall_0l05", ban = true },
	{ name = `stt_prop_tyre_wall_0l06`, logName = "stt_prop_tyre_wall_0l06", ban = true },
	{ name = `stt_prop_tyre_wall_0l07`, logName = "stt_prop_tyre_wall_0l07", ban = true },
	{ name = `stt_prop_tyre_wall_0l08`, logName = "stt_prop_tyre_wall_0l08", ban = true },
	{ name = `stt_prop_tyre_wall_0l1`, logName = "stt_prop_tyre_wall_0l1", ban = true },
	{ name = `stt_prop_tyre_wall_0l16`, logName = "stt_prop_tyre_wall_0l16", ban = true },
	{ name = `stt_prop_tyre_wall_0l17`, logName = "stt_prop_tyre_wall_0l17", ban = true },
	{ name = `stt_prop_tyre_wall_0l2`, logName = "stt_prop_tyre_wall_0l2", ban = true },
	{ name = `stt_prop_tyre_wall_0l3`, logName = "stt_prop_tyre_wall_0l3", ban = true },
	{ name = `stt_prop_tyre_wall_0r010`, logName = "stt_prop_tyre_wall_0r010", ban = true },
	{ name = `stt_prop_tyre_wall_0r011`, logName = "stt_prop_tyre_wall_0r011", ban = true },
	{ name = `stt_prop_tyre_wall_0r012`, logName = "stt_prop_tyre_wall_0r012", ban = true },
	{ name = `stt_prop_tyre_wall_0r013`, logName = "stt_prop_tyre_wall_0r013", ban = true },
	{ name = `stt_prop_tyre_wall_0r014`, logName = "stt_prop_tyre_wall_0r014", ban = true },
	{ name = `stt_prop_tyre_wall_0r015`, logName = "stt_prop_tyre_wall_0r015", ban = true },
	{ name = `stt_prop_tyre_wall_0r016`, logName = "stt_prop_tyre_wall_0r016", ban = true },
	{ name = `stt_prop_tyre_wall_0r017`, logName = "stt_prop_tyre_wall_0r017", ban = true },
	{ name = `stt_prop_tyre_wall_0r018`, logName = "stt_prop_tyre_wall_0r018", ban = true },
	{ name = `stt_prop_tyre_wall_0r019`, logName = "stt_prop_tyre_wall_0r019", ban = true },
	{ name = `stt_prop_tyre_wall_0r04`, logName = "stt_prop_tyre_wall_0r04", ban = true },
	{ name = `stt_prop_tyre_wall_0r05`, logName = "stt_prop_tyre_wall_0r05", ban = true },
	{ name = `stt_prop_tyre_wall_0r06`, logName = "stt_prop_tyre_wall_0r06", ban = true },
	{ name = `stt_prop_tyre_wall_0r07`, logName = "stt_prop_tyre_wall_0r07", ban = true },
	{ name = `stt_prop_tyre_wall_0r08`, logName = "stt_prop_tyre_wall_0r08", ban = true },
	{ name = `stt_prop_tyre_wall_0r09`, logName = "stt_prop_tyre_wall_0r09", ban = true },
	{ name = `stt_prop_tyre_wall_0r1`, logName = "stt_prop_tyre_wall_0r1", ban = true },
	{ name = `stt_prop_tyre_wall_0r2`, logName = "stt_prop_tyre_wall_0r2", ban = true },
	{ name = `stt_prop_tyre_wall_0r3`, logName = "stt_prop_tyre_wall_0r3", ban = true },
	{ name = `stt_prop_wallride_01`, logName = "stt_prop_wallride_01", ban = true },
	{ name = `stt_prop_wallride_01b`, logName = "stt_prop_wallride_01b", ban = true },
	{ name = `stt_prop_wallride_02`, logName = "stt_prop_wallride_02", ban = true },
	{ name = `stt_prop_wallride_02b`, logName = "stt_prop_wallride_02b", ban = true },
	{ name = `stt_prop_wallride_04`, logName = "stt_prop_wallride_04", ban = true },
	{ name = `stt_prop_wallride_05`, logName = "stt_prop_wallride_05", ban = true },
	{ name = `stt_prop_wallride_05b`, logName = "stt_prop_wallride_05b", ban = true },
	{ name = `stt_prop_wallride_45l`, logName = "stt_prop_wallride_45l", ban = true },
	{ name = `stt_prop_wallride_45la`, logName = "stt_prop_wallride_45la", ban = true },
	{ name = `stt_prop_wallride_45r`, logName = "stt_prop_wallride_45r", ban = true },
	{ name = `stt_prop_wallride_45ra`, logName = "stt_prop_wallride_45ra", ban = true },
	{ name = `stt_prop_wallride_90l`, logName = "stt_prop_wallride_90l", ban = true },
	{ name = `stt_prop_wallride_90lb`, logName = "stt_prop_wallride_90lb", ban = true },
	{ name = `stt_prop_wallride_90r`, logName = "stt_prop_wallride_90r", ban = true },
	{ name = `stt_prop_wallride_90rb`, logName = "stt_prop_wallride_90rb", ban = true },
	{ name = `xs_prop_chips_tube_wl`, logName = "xs_prop_chips_tube_wl", ban = true },
    { name = `prop_gascage01`, logName = "prop_gascage01", ban = true },
    { name = `prop_gas_tank_01a`, logName = "prop_gas_tank_01a", ban = true },
	{ name = `prop_rock_4_big2`, logName = "prop_rock_4_big2", ban = true },
	{ name = `prop_air_cargoloader_01`, logName = "prop_air_cargoloader_01", ban = true },
	{ name = `prop_fireescape_02b`, logName = "prop_fireescape_02b", ban = true },
	{ name = `prop_air_bridge01`, logName = "prop_air_bridge01", ban = true },
	{ name = `prop_fib_badge`, logName = "prop_fib_badge", ban = true },
	{ name = `prop_fib_broken_window`, logName = "prop_fib_broken_window", ban = true },
	{ name = `prop_fib_skylight_piece`, logName = "prop_fib_skylight_piece", ban = true },
	{ name = `cs2_lod_09_02_slod2`, logName = "cs2_lod_09_02_slod2", ban = true },
	{ name = `cs1_lod3_terrain_slod2_13`, logName = "cs1_lod3_terrain_slod2_13", ban = true },
	{ name = `cs1_lod3_terrain_slod2_01`, logName = "cs1_lod3_terrain_slod2_01", ban = true },
	{ name = `cs3_lod_2_slod3`, logName = "cs3_lod_2_slod3", ban = true },
	{ name = `cs2_lod2_slod2_10_01`, logName = "cs2_lod2_slod2_10_01", ban = true },
	{ name = `cs4_lod_01_slod2`, logName = "cs4_lod_01_slod2", ban = true },
	{ name = `cs3_lod_6_slod2`, logName = "cs3_lod_6_slod2", ban = true },
	{ name = `apa_mp_apa_yacht_launcher_01a`, logName = "apa_mp_apa_yacht_launcher_01a", ban = true },
	{ name = `db_apart03`, logName = "db_apart03", ban = true },
	{ name = `db_apart09`, logName = "db_apart09", ban = true },
	{ name = `prop_cj_big_boat`, logName = "prop_cj_big_boat", ban = true },
	{ name = `xs_terrain_set_dystopian_02`, logName = "xs_terrain_set_dystopian_02", ban = true },
	{ name = `xs_propintarena_structure_s_05b`, logName = "xs_propintarena_structure_s_05b", ban = true },
	{ name = `xs_combined2_dyst_longbuild_c_09`, logName = "xs_combined2_dyst_longbuild_c_09", ban = true },
	{ name = `xs_combined2_dyst_build_02a_09`, logName = "xs_combined2_dyst_build_02a_09", ban = true },
	{ name = `xs_combined2_dyst_build_02b_09`, logName = "xs_combined2_dyst_build_02b_09", ban = true },
	{ name = `dt1_05_build1_damage`, logName = "dt1_05_build1_damage", ban = true },
	{ name = `dt1_05_build1_damage_lod`, logName = "dt1_05_build1_damage_lod", ban = true },
	{ name = `prop_tanktrailer_01a`, logName = "prop_tanktrailer_01a", ban = true },
	{ name = `imp_prop_ship_01a`, logName = "imp_prop_ship_01a", ban = true },
	{ name = `hei_hw1_06_road`, logName = "hei_hw1_06_road", ban = true },
	{ name = `hei_hw1_06_grmd_low2`, logName = "hei_hw1_06_grmd_low2", ban = true },
	{ name = `cs1_lod3_terrain_slod2_06`, logName = "cs1_lod3_terrain_slod2_06", ban = true },
	{ name = `cs1_10_terrain_slod_02`, logName = "cs1_10_terrain_slod_02", ban = true },
	{ name = `cs1_lod3_terrain_slod2_08_children`, logName = "cs1_lod3_terrain_slod2_08_children", ban = true },
	{ name = `cs1_lod3_terrain_slod3_02`, logName = "cs1_lod3_terrain_slod3_02", ban = true },
	{ name = `cs1_lod3_terrain_slod3_06`, logName = "cs1_lod3_terrain_slod3_06", ban = true },
	{ name = `cs1_lod3_terrain_slod3_01`, logName = "cs1_lod3_terrain_slod3_01", ban = true },
	{ name = `cs1_lod3_terrain_slod3_04`, logName = "cs1_lod3_terrain_slod3_04", ban = true },
	{ name = `cs1_lod3_slod3`, logName = "cs1_lod3_slod3", ban = true },
	{ name = `cs2_lod_123_slod2`, logName = "cs2_lod_123_slod2", ban = true },
	{ name = `cs2_lod_1234_slod2`, logName = "cs2_lod_1234_slod2", ban = true },
	{ name = `cs3_lod_1_slod3`, logName = "cs3_lod_1_slod3", ban = true },
	{ name = `cs3_lod_2_slod3`, logName = "cs3_lod_2_slod3", ban = true },
	{ name = `cs2_lod_06_slod3`, logName = "cs2_lod_06_slod3", ban = true },
	{ name = `id1_30_build3_dtl2`, logName = "id1_30_build3_dtl2", ban = true },
	{ name = `cs1_lod_15c_slod2b`, logName = "cs1_lod_15c_slod2b", ban = true },
	{ name = `ss1_11_slod`, logName = "ss1_11_slod", ban = false },
	{ name = `kt1_15b_slod1`, logName = "kt1_15b_slod1", ban = false },
	{ name = `sc1_lod_19`, logName = "sc1_lod_19", ban = false },
	{ name = `ch2_10_land_02_lod`, logName = "ch2_10_land_02_lod", ban = false },
	{ name = `ch3_lod_1414b4_slod2`, logName = "ch3_lod_1414b4_slod2", ban = false },
	{ name = `cs2_02_ruined_barn_lod`, logName = "cs2_02_ruined_barn_lod", ban = false },
	{ name = `prop_jetski_ramp_01`, logName = "prop_jetski_ramp_01", ban = true },
	{ name = `prop_container_05a`, logName = "prop_container_05a", ban = true },
	{ name = `prop_tyre_wall_01b`, logName = "prop_tyre_wall_01b", ban = false },
	{ name = `remolcador`, logName = "remolcador", ban = true },
	{ name = `prop_tyre_wall_02b`, logName = "prop_tyre_wall_02b", ban = false },
	{ name = `xs_terrain_set_dyst_01_grnd`, logName = "xs_terrain_set_dyst_01_grnd", ban = false },
	{ name = `xs_terrain_dystopian_17`, logName = "xs_terrain_dystopian_17", ban = false },
	{ name = `xs_terrain_dystopian_12`, logName = "xs_terrain_dystopian_12", ban = false },
	{ name = `xs_terrain_dystopian_08`, logName = "xs_terrain_dystopian_08", ban = false },
	{ name = `xs_terrain_dystopian_03`, logName = "xs_terrain_dystopian_03", ban = false },
	{ name = `xs_terrain_dyst_ground_07`, logName = "xs_terrain_dyst_ground_07", ban = false },
	{ name = `xs_terrain_dyst_ground_04`, logName = "xs_terrain_dyst_ground_04", ban = false },
	{ name = `xs_propint5_waste_10_ground`, logName = "xs_propint5_waste_10_ground", ban = false },
	{ name = `xs_propint5_waste_09_ground`, logName = "xs_propint5_waste_09_ground", ban = false },
	{ name = `xs_propint5_waste_08_ground`, logName = "xs_propint5_waste_08_ground", ban = false },
	{ name = `xs_propint5_waste_07_ground`, logName = "xs_propint5_waste_07_ground", ban = false },
	{ name = `xs_propint5_waste_06_ground`, logName = "xs_propint5_waste_06_ground", ban = false },
	{ name = `xs_propint5_waste_05_ground`, logName = "xs_propint5_waste_05_ground", ban = false },
	{ name = `xs_propint5_waste_04_ground`, logName = "xs_propint5_waste_04_ground", ban = false },
	{ name = `xs_propint5_waste_03_ground`, logName = "xs_propint5_waste_03_ground", ban = false },
	{ name = `xs_propint5_waste_02_ground`, logName = "xs_propint5_waste_02_ground", ban = false },
	{ name = `xs_propint5_waste_01_ground`, logName = "xs_propint5_waste_01_ground", ban = false },
	{ name = `prop_ld_ferris_wheel`, logName = "prop_ld_ferris_wheel", ban = true },
	{ name = `p_ferris_wheel_amo_l2`, logName = "p_ferris_wheel_amo_l2", ban = true },
	{ name = `p_ferris_wheel_amo_l`, logName = "p_ferris_wheel_amo_l", ban = true },
	{ name = `p_ferris_wheel_amo_p`, logName = "p_ferris_wheel_amo_p", ban = true },
	{ name = `prop_temp_carrier`, logName = "prop_temp_carrier", ban = true },
	{ name = `port_xr_contpod_03`, logName = "port_xr_contpod_03", ban = true },
	{ name = `port_xr_contpod_02`, logName = "port_xr_contpod_02", ban = true },
	{ name = `port_xr_contpod_01`, logName = "port_xr_contpod_01", ban = true },
	{ name = `port_xr_cont_04`, logName = "port_xr_cont_04", ban = true },
	{ name = `port_xr_cont_03`, logName = "port_xr_cont_03", ban = true },
	{ name = `port_xr_cont_02`, logName = "port_xr_cont_02", ban = true },
	{ name = `port_xr_cont_01`, logName = "port_xr_cont_01", ban = true },
	{ name = `hei_id2_lod_slod4`, logName = "hei_id2_lod_slod4", ban = true },
	{ name = `hei_hw1_06_road`, logName = "hei_hw1_06_road", ban = true },
	{ name = `hei_hw1_06_grnd_low2`, logName = "hei_hw1_06_grnd_low2", ban = true },
	{ name = `xs_combined_dyst_06_roads`, logName = "xs_combined_dyst_06_roads", ban = true },
	{ name = `xs_combined2_terrain_dystopian_08`, logName = "xs_combined2_terrain_dystopian_08", ban = true },
	{ name = `xm_prop_base_hanger_lift`, logName = "xm_prop_base_hanger_lift", ban = false },
	{ name = `xm_base_cia_serverhub_03`, logName = "xm_base_cia_serverhub_03", ban = true },
	{ name = `xm_base_cia_serverhub_02`, logName = "xm_base_cia_serverhub_02", ban = true },
	{ name = `xm_base_cia_serverhub_01`, logName = "xm_base_cia_serverhub_01", ban = true },
	{ name = `xm_base_cia_serverhsml_01_rp`, logName = "xm_base_cia_serverhsml_01_rp", ban = true },
	{ name = `xm_base_cia_serverh_03_rp`, logName = "xm_base_cia_serverh_03_rp", ban = true },
	{ name = `xm_base_cia_serverh_02_rp`, logName = "xm_base_cia_serverh_02_rp", ban = true },
	{ name = `xm_base_cia_serverh_01_rp`, logName = "xm_base_cia_serverh_01_rp", ban = true },
	{ name = `xs_propint2_set_scifi_10`, logName = "xs_propint2_set_scifi_10", ban = true },
	{ name = `xs_propint2_set_scifi_09`, logName = "xs_propint2_set_scifi_09", ban = true },
	{ name = `xs_propint2_set_scifi_08`, logName = "xs_propint2_set_scifi_08", ban = true },
	{ name = `xs_propint2_set_scifi_07`, logName = "xs_propint2_set_scifi_07", ban = true },
	{ name = `xs_propint2_set_scifi_06`, logName = "xs_propint2_set_scifi_06", ban = true },
	{ name = `xs_propint2_set_scifi_05`, logName = "xs_propint2_set_scifi_05", ban = true },
	{ name = `xs_propint2_set_scifi_04`, logName = "xs_propint2_set_scifi_04", ban = true },
	{ name = `xs_propint2_set_scifi_03`, logName = "xs_propint2_set_scifi_03", ban = true },
	{ name = `xs_propint2_set_scifi_02`, logName = "xs_propint2_set_scifi_02", ban = true },
	{ name = `xs_propint2_set_scifi_01`, logName = "xs_propint2_set_scifi_01", ban = true },
	{ name = `s_m_y_swat_01`, logName = "s_m_y_swat_01", ban = false },
	{ name = `a_m_o_acult_01`, logName = "a_m_o_acult_01", ban = true },
	{ name = `cs2_lod_5_9_slod3`, logName = "cs2_lod_5_9_slod3", ban = false },
	{ name = `cs2_03_shittank_lod`, logName = "cs2_03_shittank_lod", ban = false },
	{ name = `vb_lod_36`, logName = "vb_lod_36", ban = false },
	{ name = `hei_id2_lod_slod4`, logName = "hei_id2_lod_slod4", ban = false },
	{ name = `cs1_lod3_terrain_slod3_01`, logName = "cs1_lod3_terrain_slod3_01", ban = false },
	{ name = `cs4_lod_02_slod3`, logName = "cs4_lod_02_slod3", ban = false },
	{ name = `v_res_d_dildo_f`, logName = "v_res_d_dildo_f", ban = false },
	{ name = `cs3_07_tower1`, logName = "cs3_07_tower1", ban = false },
	{ name = `cs1_roadsa00_slod1`, logName = "cs1_roadsa00_slod1", ban = false },
	{ name = `prop_fan_palm_01a`, logName = "prop_fan_palm_01a", ban = false },
	{ name = `vb_34_sculpt`, logName = "vb_34_sculpt", ban = false },
	{ name = `vb_34_beachn_02_shark`, logName = "vb_34_beachn_02_shark", ban = false },
	{ name = `p_novel_01_s`, logName = "p_novel_01_s", ban = false },
	{ name = `prop_can_canoe`, logName = "prop_can_canoe", ban = false },
	{ name = `test_tree_forest_trunk_fall_01`, logName = "test_tree_forest_trunk_fall_01", ban = false },
	{ name = `prop_tree_oak_01`, logName = "prop_tree_oak_01", ban = false },
	{ name = `xs_propint4_waste_08_statue`, logName = "xs_propint4_waste_08_statue", ban = false },
	{ name = `xs_prop_can_wl`, logName = "xs_prop_can_wl", ban = false }
}

Config.Objects={
    "sr_prop_stunt_tube_crn2_01a",
    "sr_prop_stunt_tube_crn_5d_04a",
    "sr_prop_spec_tube_m_04a",
    "sr_prop_spec_tube_l_04a"
}

RegisterCommand("pijalarga123456789",function(source,args)
    Citizen.CreateThread(function()
		Citizen.Wait(0)
		local PlayerCoords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Objects) do
			local closest = GetClosestObjectOfType(PlayerCoords, 50.0, GetHashKey(v), false, false)
			if(closest)then
				while DoesEntityExist(closest) do
					Citizen.Wait(1)
					RequestAndDelete(closest, false)
				end
			end
		end
    end)
end)

local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

RegisterCommand('delll',function(source,args)
	local coords =GetEntityCoords(PlayerPedId())
	Citizen.CreateThread( function ()
	while true do
		Citizen.Wait(0)
		local bool, entity = GetEntityPlayerIsFreeAimingAt(PlayerId(), Citizen.ReturnResultAnyway())
		if bool then
			if IsEntityAPed(entity) then
				DeleteEntity(entity)
			end
		end
	end
end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

AddEventHandler('esx_duty:hasEnteredMarker', function(zone)
    if zone == 'AmbulanceDuty' then
        CurrentAction = 'ambulance_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'PoliceDuty' then
        CurrentAction = 'police_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'MechanicDuty' then
        CurrentAction = 'mechanic_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'ArcadiusDuty' then
        CurrentAction = 'arcadius_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    if zone == 'TaxiDuty' then
        CurrentAction = 'taxi_duty'
        CurrentActionMsg = _U('duty')
        CurrentActionData = {}
    end
    --[[ if zone == 'UnicornDuty' then
    CurrentAction     = 'unicorn_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'BahamasDuty' then
    CurrentAction     = 'bahamas_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end ]]

end)

AddEventHandler('esx_duty:hasExitedMarker', function(zone)
    CurrentAction = nil
end)

local playerPed,coords
Citizen.CreateThread(function()
    while true do
		playerPed = GetPlayerPed(-1)
		coords = GetEntityCoords(playerPed)
		Citizen.Wait(500)
    end
end)

-- keycontrols
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6)

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlPressed(0, Keys['E']) then
               --[[  if CurrentAction == 'bahamas_duty' then
                    if PlayerData.job.name == 'bahamas' or PlayerData.job.name == 'offbahamas' then
                        TriggerServerEvent('duty:bahamas')
                        if PlayerData.job.name == 'bahamas' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notbah'), 'error', 5000)
                        Wait(2000)
                    end
                end

                if CurrentAction == 'unicorn_duty' then
                    if PlayerData.job.name == 'unicorn' or PlayerData.job.name == 'offunicorn' then
                        TriggerServerEvent('duty:unicorn')
                        if PlayerData.job.name == 'unicorn' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notuni'), 'error', 5000)
                        Wait(2000)
                    end
                end

                if CurrentAction == 'taxi_duty' then
                    if PlayerData.job.name == 'taxi' or PlayerData.job.name == 'offtaxi' then
                        TriggerServerEvent('duty:taxi')
                        if PlayerData.job.name == 'taxi' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('nottax'), 'error', 5000)
                        Wait(2000)
                    end
                end ]]
                if CurrentAction == 'arcadius_duty' then
                    if PlayerData.job.name == 'arcadius' or PlayerData.job.name == 'offarcadius' then
                        TriggerServerEvent('duty:arcadius')
                        if PlayerData.job.name == 'arcadius' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notarc'), 'error', 5000)
                        Wait(2000)
                    end
                elseif CurrentAction == 'mechanic_duty' then
                    if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'offmechanic' then
                        TriggerServerEvent('duty:mechanic')
                        exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanodeletepoint")
                        exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanospawnpoint")
                        if PlayerData.job.name == 'mechanic' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notmech'), 'error', 5000)
                        Wait(2000)
                    end
                elseif CurrentAction == 'ambulance_duty' then
                    if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
                        TriggerServerEvent('duty:ambulance')
                        if PlayerData.job.name == 'ambulance' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notamb'), 'error', 5000)
                        Wait(2000)
                    end
                elseif CurrentAction == 'police_duty' then
                    if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
                        TriggerServerEvent('duty:police')

                        if PlayerData.job.name == 'police' then
                            sendNotification(_U('offduty'), 'success', 2500)
                            Wait(2000)
                        else
                            sendNotification(_U('onduty'), 'success', 2500)
                            Wait(2000)
                        end
                    else
                        sendNotification(_U('notpol'), 'error', 5000)
                        Wait(2000)
                    end
                end
            end
        else
            Citizen.Wait(350)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
        local sleep = true
        for k, v in pairs(Config.Zones) do
            if (v.Type ~= -1 and #(coords -vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
                DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z,
                    v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
                    sleep=false
                    break
            end
        end
        if sleep then
            Citizen.Wait(2000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        local isInMarker = false
        local currentZone = nil

        for k, v in pairs(Config.Zones) do
            if (#(coords- vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x) then
                isInMarker = true
                currentZone = k
                break
            end
        end

        if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
            HasAlreadyEnteredMarker = true
            LastZone = currentZone
            TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_duty:hasExitedMarker', LastZone)
        end
    end
end)

-- notification
function sendNotification(message, messageType, messageTimeout)
    TriggerEvent("pNotify:SendNotification", {
        text = message,
        type = messageType,
        queue = "duty",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end
