//::///////////////////////////////////////////////
//:: Flame Weapon
//:: sp_flmeweap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives a melee weapon 1d6 damage +1 per caster
  level/4 to a maximum of +10 for caster lvl rounds. 
  Dmg type follows subradial menu: 
  fire, acid, cold, electricity
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 29, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-15: Complete Rewrite to make use of Item Property System
//:: 2014_04_17: added acid, cold and electricity dmg & support of subradial spells




#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "nw_i0_spells"
#include "x2_i0_spells"


void main()
{

    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    // End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int iIPConstDmgTypeID = IP_CONST_DAMAGETYPE_FIRE;
    int nSpell = GetSpellId();
    int iCastingVisualEffectID = VFX_IMP_PULSE_FIRE; // default casting visual effect
    int iItemVisualTypeID = ITEM_VISUAL_FIRE; // default on-weapon visual effect 
    int iDmgTypeID = ITEM_VISUAL_FIRE;    // default dmg type
    
    
    //Determine subradial type
    if (nSpell == 953)     // acid dmg
    {
      iCastingVisualEffectID = VFX_IMP_MAGBLUE;
      iItemVisualTypeID = ITEM_VISUAL_ACID;
      iDmgTypeID = IP_CONST_DAMAGETYPE_ACID;
    }
    else if (nSpell == 954)         // cold dmg
    {
      iCastingVisualEffectID = VFX_IMP_PULSE_COLD;
      iItemVisualTypeID = ITEM_VISUAL_COLD;
      iDmgTypeID = IP_CONST_DAMAGETYPE_COLD;
    }
    else if (nSpell == 955)    // electrical dmg
    {
      iCastingVisualEffectID = VFX_IMP_PULSE_WIND;
      iItemVisualTypeID = ITEM_VISUAL_ELECTRICAL;
      iDmgTypeID = IP_CONST_DAMAGETYPE_ELECTRICAL;
    }
    else
    // fire dmg
    {
      iCastingVisualEffectID = VFX_IMP_PULSE_FIRE; // change casting effect to default (_PULSE_FIRE))
      iItemVisualTypeID = ITEM_VISUAL_FIRE;
      iDmgTypeID = IP_CONST_DAMAGETYPE_FIRE;
    }    
    
    effect eVis = EffectVisualEffect(iCastingVisualEffectID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF)+1;
    nCasterLvl = GetThalieCaster(OBJECT_SELF, oTarget, nCasterLvl,FALSE);
    int nDuration = 2 * nCasterLvl;
    int nMetaMagic = GetMetaMagicFeat();
    int iBonus = d6()+nCasterLvl/4;
    if (iBonus > 10)
    {
        iBonus = 10;
    }
    itemproperty ip = ItemPropertyDamageBonus(iDmgTypeID, GetIPDamageBonusByValue(iBonus));

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    float fDuration = RoundsToSeconds(nDuration);
    object oMyWeapon = oTarget;

    // ---------------- TARGETED ON BOLT  -------------------
    if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        // special handling for blessing crossbow bolts that can slay rakshasa's
        int iItemType = GetBaseItemType(oTarget);
        if (iItemType == BASE_ITEM_BOLT ||
            iItemType == BASE_ITEM_ARROW ||
            iItemType == BASE_ITEM_BULLET)
        {
          //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
          if (nDuration>0) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oMyWeapon, fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(iItemVisualTypeID), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
            return;
          }
        }
    }

    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oMyWeapon, fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(iItemVisualTypeID), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        }
    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oMyWeapon, fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(iItemVisualTypeID), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
    if(GetIsObjectValid(oMyWeapon) && GetBaseItemType(oMyWeapon) == BASE_ITEM_GLOVES )
    {
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oMyWeapon, fDuration);
        }

    }

}
