DnaTracker = {}
local MFD = DnaTracker
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFD.Version = '1.0.10'

MFD.BloodObject = "p_bloodsplat_s"
MFD.ResidueObject = "w_pi_flaregun_shell"

-- JOB Database Table: LABEL
MFD.PoliceJob = "LSPD"
MFD.AmbulanceJob = "LSPD"

MFD.DNAAnalyzePos = vector3(445.25, -996.75, 34.97)
MFD.AmmoAnalyzePos = vector3(441.17, -996.74, 34.98)
MFD.DrawTextDist = 1.0
MFD.MaxObjCount = 10