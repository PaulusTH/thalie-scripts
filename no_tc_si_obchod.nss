//::///////////////////////////////////////////////
//:: FileName no_tc_br_obchod
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created On: 17.10.2008 17:41:37
//::  by Nomis
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
//nacteme z obchodnika promennou string no_obchod
// ma hodnoty:  kara,doub,tart



// Bu� otev�i obchod s t�mto tagem, nebo u�ivateli oznam, �e ��dn� obchod neexistuje.


    object oStore = GetObjectByTag("no_tcob_si_" + GetLocalString(OBJECT_SELF,"no_obchod"));


if ( GetIsObjectValid(oStore)== TRUE ) {
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore,GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK); }

//jestlize obchod neexistuje, udelame si ho (.
if ( GetIsObjectValid(oStore)== FALSE ) {
location no_lokace = GetLocation(OBJECT_SELF);
oStore = CreateObject(OBJECT_TYPE_STORE,"no_tcob_si_kara",no_lokace,FALSE,("no_tcob_si_" + GetLocalString(OBJECT_SELF,"no_obchod")));
        OpenStore(oStore,GetPCSpeaker());
//////////////kdyz ho mame otevrenej tak podle promenne umazene patricne veci z obchodu ///////

if ((GetLocalString(OBJECT_SELF,"no_obchod")== "doub") || (GetLocalString(OBJECT_SELF,"no_obchod")== "hago")) {
object no_Item = GetFirstItemInInventory(oStore);
while(GetIsObjectValid(no_Item))  {
if   (GetTag(no_Item)=="no_lepi_lege" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_lepi_velm" )  DestroyObject(no_Item);
no_Item = GetNextItemInInventory(oStore);
} }

if (GetLocalString(OBJECT_SELF,"no_obchod")== "tart") {
object no_Item = GetFirstItemInInventory(oStore);
while(GetIsObjectValid(no_Item))  {
if   (GetTag(no_Item)=="no_lepi_lege" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_lepi_velm" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_leps_mist" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_lepi_lege" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_lepi_kval" )  DestroyObject(no_Item);
no_Item = GetNextItemInInventory(oStore);
} }




///////////////konec mazani veci podle promennych //////////////////////////////////////////

}
}


