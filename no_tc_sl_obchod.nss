//::///////////////////////////////////////////////
//:: FileName no_tc_sl_obchod
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


    object oStore = GetObjectByTag("no_tcob_sl_" + GetLocalString(OBJECT_SELF,"no_obchod"));


if ( GetIsObjectValid(oStore)== TRUE ) {
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        OpenStore(oStore,GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK); }

//jestlize obchod neexistuje, udelame si ho (.
if ( GetIsObjectValid(oStore)== FALSE ) {
location no_lokace = GetLocation(OBJECT_SELF);
oStore = CreateObject(OBJECT_TYPE_STORE,"no_tcob_sl_kara",no_lokace,FALSE,("no_tcob_sl_" + GetLocalString(OBJECT_SELF,"no_obchod")));
        OpenStore(oStore,GetPCSpeaker());
//////////////kdyz ho mame otevrenej tak podle promenne umazene patricne veci z obchodu ///////
if ((GetLocalString(OBJECT_SELF,"no_obchod")== "doub") || (GetLocalString(OBJECT_SELF,"no_obchod")== "hago")) {
object no_Item = GetFirstItemInInventory(oStore);
while(GetIsObjectValid(no_Item))  {
if   (GetTag(no_Item)=="no_legu_mete" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_stin" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_mete" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_silv" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_tita" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_adam" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_mith" )  DestroyObject(no_Item);
no_Item = GetNextItemInInventory(oStore);
} }

if (GetLocalString(OBJECT_SELF,"no_obchod")== "tart") {
object no_Item = GetFirstItemInInventory(oStore);
while(GetIsObjectValid(no_Item))  {
if   (GetTag(no_Item)=="no_legu_mete" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_stin" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_mete" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_silv" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_tita" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_adam" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_mith" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_plat" )  DestroyObject(no_Item);
if   (GetTag(no_Item)=="no_legu_gold" )  DestroyObject(no_Item);
no_Item = GetNextItemInInventory(oStore);
} }
///////////////konec mazani veci podle promennych //////////////////////////////////////////
                             }
}



