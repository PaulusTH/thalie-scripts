/// ku_xpdummy_dmg - On damaged script for combat dummy to give xp

void main()
{
    object oDummy = OBJECT_SELF;
    // amount of xp per damage point
    int nXP = GetLocalInt(oDummy, "__XP");
    // Max amount of xp a PC can get from the Dummy
    int nXPMax = GetLocalInt(oDummy, "__MAX_XP"); // Max amount of xp a PC can get from the Dummy
    int nMaxLevel = GetLocalInt(oDummy, "__MAX_LEVEL"); // Max level the PC can be to still gain xp from betting up a Dummy
    int nDam = GetTotalDamageDealt();
    object oPC = GetLastDamager();
    if(GetIsPC(oPC) && GetHitDice(oPC) <= nMaxLevel && GetLocalInt(OBJECT_SELF,GetName(oPC)) < nXPMax+1)
        {
        GiveXPToCreature(oPC,nDam*nXP);
        SetLocalInt(OBJECT_SELF,GetName(oPC),GetLocalInt(OBJECT_SELF,GetName(oPC)) + nDam*nXP);
        // Heal the dummy so it don't get destroyed
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nDam),OBJECT_SELF);
        }
    else
        {
        SendMessageToPC(oPC,"You have exceeded Level "+IntToString(nMaxLevel));
        SendMessageToPC(oPC,"Or you have gained "+IntToString(nXPMax)+" amount of xp");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(nDam),OBJECT_SELF);
        }
}