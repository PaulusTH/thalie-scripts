#include "nwnx_funcs"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int iPart;
    int iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO);
    int iAC = StringToInt(Get2DAString("parts_chest", "ACBONUS", iVal));
    int iTemplateAC = GetLocalInt(OBJECT_SELF, "TEMPLATEAC");
    
    for (iPart = 0; iPart < 19; iPart++)
    {
        if (iPart == ITEM_APPR_ARMOR_MODEL_TORSO && iAC != iTemplateAC)
            continue;
            
        iVal = GetLocalInt(OBJECT_SELF, "TEMPLATE" + IntToString(iPart));
        SetItemAppearance(oItem, iPart, iVal);
    }
}