/*
													Basic Gamemode Lrp v9 Fixed

-Thakst To My God (ALLAH SWT)
-Thaks To Aurthor Gamemode (Dandy Prasetyo)
-Tanks To All Staff LegacyPride
-New System From Developer LegacyPride (Twosix/Bobi)

							[-----------------------------------------------]
							[	`Basic Script : Dandy Prasetyo              ]
							[-----------------------------------------------]
							[          		FEATURE UPDATE                  ]
							[                                               ]
							[   `Ucp system with 3 charakter                ]
							[   `Player Vehicle / Private Vehicle system    ]
							[   `Dealership Owner System                    ]
							[   `Player Progressbar²                        ]
							[   `Hunger & Thirsty System With TD HBE        ]
							[   `Etc More Featured                          ]
							[                                               ]
							[-----------------------------------------------]

		**Coding Itu Bisa Di Copy Paste, Tapi Ide Seseorang Tidak Bisa (Tian Metal - Christian Malik)**
*/

//---- [ Include ]----
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS	500
#include <crashdetect.inc>
#include <gvar.inc>
#include <a_mysql>
#include <a_actor>
#include <a_http>
#include <a_objects>
#include <a_zones>
#include <a_graphfunc>
#include <CTime>
#include <Dini>
#include <progress2.inc>
#include <Pawn.CMD.inc>
#include <mSelection.inc>
#include <TimestampToDate.inc>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <streamer.inc>
#include <EVF.inc>
#include <ColAndreas>
#include <3DTryg>
#include <VehPara>
#include <YSI\y_timers>
#include <YSI\y_iterate>
#include <sscanf2.inc>
#include <yom_buttons.inc>
#include <geolocation.inc>
#include <garageblock.inc>
#include <timerfix.inc>
#include <discord-cmd>
#include <discord-connector.inc>
#include <anti-cheat>
#include "../include/gl_common.inc"
//-----[ Bobstoneeeeeee ]------
#define JoinLeaveDiscord "899303664236232744"
#define ChatDiscord "899292799109853197"
//-----[ Modular ]-----
#include "MODULE\DEFINE.pwn"
#include "MODULE\COLOR.pwn"
#include "MODULE\TEXTDRAW.pwn"
#define CONVERT_TIME_TO_SECONDS 	1
#define CONVERT_TIME_TO_MINUTES 	2
#define CONVERT_TIME_TO_HOURS 		3
#define CONVERT_TIME_TO_DAYS 		4
#define CONVERT_TIME_TO_MONTHS 		5
#define CONVERT_TIME_TO_YEARS 		6
#define MAX_AUCTIONS    10
//--- [ New Variable ] ----//
// Elevator floor names for the 3D text labels
static FloorNames[11][] =
{
	"Car Park",
	"Ground Floor",
	"First Floor",
	"Second Floor",
	"Third Floor",
	"Fourth Floor",
	"Fifth Floor",
	"Sixth Floor",
	"Seventh Floor",
	"Eighth Floor",
	"Ninth Floor"
};

// Blindfold
new pBlind[MAX_PLAYERS] = 1; //
new weather_id = 1;
new DmvVeh[1];
//anti spam veh
new VehicleLastEnterTime[MAX_PLAYERS],
    Warning[MAX_PLAYERS];
//New GMX
new CurGMX;
//afk
new p_tick[MAX_PLAYERS],
    p_afktime[MAX_PLAYERS];
//Enum GMX
forward DoGMX();
//anti aimbot
new AimbotWarnings[MAX_PLAYERS];
//display online
new online;
//Mapping
//new tmpobjid;
new togtextdraws[MAX_PLAYERS];
new Text:txtAnimHelper;
//dealer
new ramp[6];
new ddor[20];
new bool:ddstate;
new bool:rstate;
new Text3D:oclabel[2];

//Siren Lights
new Flasher[MAX_VEHICLES] = 0;
new FlasherState[MAX_VEHICLES];
new FlashTimer;
//new vehicleSiren[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};

//siren
forward FlasherFunc();
public FlasherFunc() {
	new panelsx,doorsx,lightsx,tiresx;
	for (new p=0; p<MAX_VEHICLES; p++)
	{
		if (Flasher[p] == 1)
		{
			if (FlasherState[p] == 1)
			{
				GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
				UpdateVehicleDamageStatus(p, panelsx, doorsx, 4, tiresx);
				FlasherState[p] = 0;
			}
			else
			{
				GetVehicleDamageStatus(p,panelsx,doorsx,lightsx,tiresx);
				UpdateVehicleDamageStatus(p, panelsx, doorsx, 1, tiresx);
				FlasherState[p] = 1;
			}
		}
	}
	return 1;
}

// Player data
enum E_PLAYERS
{
	pID,
	pVerfi[64],
	pVerifikasi,
	pUCP[22],
	pExtraChar,
	pTempPass[64],
	pChar,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pIP[16],
	pPassword[65],
	pSalt[17],
	pEmail[40],
	pAdmin,
	pHelper,
	pLevel,
	pLevelUp,
	pVip,
	pVipTime,
	//charakter Story
	pPlayerCS,
 	// Roleplay Booster
 	pBooster,
 	pBoostTime,
	pGold,
	pRegDate[50],
	pLastLogin[50],
	pMoney,
	pBankMoney,
	pBankRek,
	//phone
	pContact,
	pPhone,
	pPhoneOff,
	pPhoneCredit,
	pPhoneBook,
	pSMS,
	pCall,
	pCallTime,
	// WS
	pMenuType,
	pInWs,
	pTransferWS,
	//--
	pWT,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	pSkin,
	pFacSkin,
	pGender,
	pAge[50],
	pInDoor,
	pInHouse,
	pInBiz,
	pInVending,
	pInDealer,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	pInt,
	pWorld,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pEnergy,
	pHungerTime,
	pEnergyTime,
	pSick,
	pSickTime,
	pHospital,
	pHospitalTime,
	pInjured,
	pOnDuty,
	pOnDutyTime,
	pFaction,
	pFactionRank,
	pFactionLead,
	pTazer,
	pBroadcast,
	pNewsGuest,
	pFarm,
	pFarmRank,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pArrest,
	pArrestTime,
	pWarn,
	pJob,
	pJob2,
	pExitJob,
	pMedicine,
	pMedkit,
	pMask,
	pFightStyle,
	pGymVip,
	pFitnessTimer,
	pFitnessType,
	pCrack,
	pBorax,
	pGetBorax,
	pPaketBorax,
	pProsesBorax,
	pRedMoney,
	pLegCoint,
	pSeatBelt,
	pHelmet,
	pSnack,
	pFlashlight,
	pUsedFlashlight,
	pSprunk,
	pMineral,
	pAyam,
	pBurger,
	pNasi,
	pTrash,
	pBerry,
	pGas,
	pBandage,
	pGPS,
	pMaterial,
	pComponent,
	pFood,
	pFrozenPizza,
	pSeed,
	pPotato,
	pWheat,
	pOrange,
	pPrice1,
	pPrice2,
	pPrice3,
	pPrice4,
	pMarijuana,
	pBlindfold,
	pArmor,
	pPlant,
	pPlantTime,
	pFishTool,
	pWorm,
	pFish,
	pInFish,
	pIDCard,
	pTicket,
	pIDCardTime,
	pLicBiz,
	pLicBizTime,
	pSkck,
	pSkckTime,
	pPenebangs,
	pPenebangsTime,
	pBpjs,
	pBpjsTime,
	pDriveLic,
	pDriveLicTime,
	pSekolahSim,
	pRobb,
	pBoatLic,
	pBoatLicTime,
	pFlyLic,
	pFlyLicTime,
	pGuns[13],
    pAmmo[13],
	pWeapon,
	pJetpack,
	pBoombox,
	//garkot
	pPark,
	pLoc,
	//Not Save
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,
	pSpawned,
	pAdminDuty,
	pFreezeTimer,
	pFreeze,
	pMaskID,
	pMaskOn,
	pSPY,
	pTname[MAX_PLAYER_NAME],
	pTweet,
	pTogTweet,
	pToggleAtm,
	pTogPM,
	pTogLog,
	pTogAds,
	pTogWT,
	pUsingWT,
	pClickMap,
	// Suspect
 	pSuspectTimer,
 	pSuspect,
	Text3D:pAdoTag,
	Text3D:pCatTag,
	bool:pAdoActive,
	pFlare,
	bool:pFlareActive,
	pTrackCar,
	pBuyPvModel,
	pTrackHouse,
	pTrackBisnis,
	pFacInvite,
	pFacOffer,
	pFamInvite,
	pFamOffer,
	pFarmInvite,
	pFarmOffer,
	pFindEms,
	pCuffed,
	toySelected,
	venSelected,
	TEditStatus,
	bool:PurchasedToy,
	pEditingItem,
	pProductModify,
	pEditingVendingItem,
	pVendingProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	playerSpectated,
	pInspectOffer,
	Float:pBodyCondition[6],
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHBEMode,
	pTDMode,
	pHelmetOn,
	pReportTime,
	pAskTime,
	//Player Progress Bar
	PlayerBar:fuelbar,
	PlayerBar:damagebar,
	PlayerBar:hungrybar,
	PlayerBar:energybar,
	PlayerBar:BarHp,
	PlayerBar:BarArmour,
	PlayerBar:bladdybar,
	PlayerBar:spfuelbar,
	PlayerBar:spdamagebar,
	PlayerBar:sphungrybar,
	PlayerBar:spenergybar,
	PlayerBar:spbladdybar,
	PlayerBar:activitybar,
	pProducting,
	pCooking,
	pArmsDealer,
	pMechanic,
	pActivity,
	pActivityTime,
	//Delay sidejob
	pSweeperTime,
	pBusTime,
	pForkliftTime,
	pPizzaTime,
	//Jobs
	pSideJob,
	pSideJobTime,
	pJobTime,
	pGetJob,
	pGetJob2,
	pTaxiDuty,
	pTaxiTime,
	pFare,
	pFareTimer,
	pTotalFare,
	Float:pFareOldX,
	Float:pFareOldY,
	Float:pFareOldZ,
	Float:pFareNewX,
	Float:pFareNewY,
	Float:pFareNewZ,
	pMechDuty,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	//ATM
	EditingATMID,
	//Graffity
	EditingGraffity,
	// Vending
	EditingVending,
	//Vehicle Toys
	EditingVtoys,
	//Limit Speed
	Float:pLimitSpeed,
	LimitSpeedTimer,
	pLsVehicle,
	//lumber job
	EditingTreeID,
	CuttingTreeID,
	bool:CarryingLumber,
	//Berry Farmers
	EditingBerryID,
	HarvestBerryID,
	//Miner job
	EditingOreID,
	MiningOreID,
	CarryingLog,
	LoadingPoint,
	//production
	CarryProduct,
	//trucker
	pMission,
	pDealerMission,
	pHauling,
	pRestock,
	//Farmer
	pHarvest,
	pHarvestID,
	pOffer,
	//Smuggler
	pSmugglerTimer,
	pPacket,
	//Bank
	pTransfer,
	pTransferRek,
	pTransferName[128],
	//Gas Station
	pFill,
	pFillTime,
	pFillPrice,
	//Gate
	gEditID,
	gEdit,
	//Workshop
	pWsEmplooye[4],
	pWsVeh,
	pWorkshop,
	//auto rp
	pSavedRp[70],
	//Skill
	pTruckSkill,
	pMechSkill,
	pSmuggSkill,
	//Vehicle Toys
	EditStatus,
	VehicleID
	//
};
new pData[MAX_PLAYERS][E_PLAYERS];

// MySQL connection handle
new MySQL: g_SQL;
new g_MysqlRaceCheck[MAX_PLAYERS];

enum    AsuKoe
{
	SKM, ROB
};
new Global[AsuKoe];

//DIALOG
enum
{
    //DEALER
	DIALOG_BUYJOBCARSVEHICLE,
	DIALOG_BUYDEALERCARS_CONFIRM,
	DIALOG_BUYTRUCKVEHICLE,
	DIALOG_BUYMOTORCYCLEVEHICLE,
	DIALOG_BUYUCARSVEHICLE,
	DIALOG_BUYCARSVEHICLE,
	DIALOG_DEALER_MANAGE,
	DIALOG_DEALER_VAULT,
	DIALOG_DEALER_WITHDRAW,
	DIALOG_DEALER_DEPOSIT,
	DIALOG_DEALER_NAME,
	DIALOG_DEALER_RESTOCK,
	DIALOG_PVSAPD,
	DIALOG_PVSAMD,
	DIALOG_VEHCO,
    //Vending
	DIALOG_VENDING_BUYPROD,
	DIALOG_VENDING_MANAGE,
	DIALOG_VENDING_NAME,
	DIALOG_VENDING_VAULT,
	DIALOG_VENDING_WITHDRAW,
	DIALOG_VENDING_DEPOSIT,
	DIALOG_VENDING_EDITPROD,
	DIALOG_VENDING_PRICESET,
	DIALOG_VENDING_RESTOCK,
	//workshop
	DIALOG_MY_WS,
	WS_MENU,
	WS_SETNAME,
	WS_SETOWNER,
	WS_SETEMPLOYE,
	WS_SETEMPLOYEE,
	WS_SETOWNERCONFIRM,
	WS_SETMEMBER,
	WS_SETMEMBERE,
	WS_MONEY,
	WS_WITHDRAWMONEY,
	WS_DEPOSITMONEY,
	WS_COMPONENT,
	WS_COMPONENT2,
	WS_MATERIAL,
	WS_MATERIAL2,
	//tes
	DIALOG_NGENTOD,
	DIALOG_CHANGELOGS,
	//---[ DIALOG PUBLIC ]---
	DIALOG_UNUSED,
	DIALOG_VERIFIKASI,
	DIALOG_MAKE_CHAR,
	DIALOG_CHARLIST,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_EMAIL,
	DIALOG_PASSWORD,
	DIALOG_STATS,
	DIALOG_SETTINGS,
	DIALOG_HBEMODE,
	DIALOG_TDMODE,
	DIALOG_CHANGEAGE,
	//-----------------------
	DIALOG_GOLDSHOP,
	DIALOG_GOLDNAME,
	//---[ DIALOG BISNIS ]---
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_SEALED,
	DIALOG_UNSEALED,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,
	BISNIS_SONG,
	BISNIS_PH,
	//--[Dialog Graffity]--
	DIALOG_WELCOME,
	DIALOG_SELECT,
	DIALOG_INPUTGRAFF,
	DIALOG_COLOR,
	DIALOG_HAPPY,
	DIALOG_LIST,
	BUY_SPRAYCAN,
	DIALOG_GOMENU,
	DIALOG_GDOBJECT,
	//---[ DIALOG HOUSE ]---
	DIALOG_SELL_HOUSES,
	DIALOG_SELL_HOUSE,
	DIALOG_MY_HOUSES,
	HOUSE_INFO,
	HOUSE_STORAGE,
	HOUSE_WEAPONS,
	HOUSE_MONEY,
	HOUSE_WITHDRAWMONEY,
	HOUSE_DEPOSITMONEY,
	//---[ DIALOG PRIVATE VEHICLE ]---
	DIALOG_FINDVEH,
	DIALOG_TRACKVEH,
	DIALOG_GOTOVEH,
	DIALOG_GETVEH,
	DIALOG_DELETEVEH,
	DIALOG_BUYPV,
	DIALOG_BUYVIPPV,
	DIALOG_BUYPLATE,
	DIALOG_BUYPVCP,
	DIALOG_BUYPVCP_BIKES,
	DIALOG_BUYPVCP_CARS,
	DIALOG_BUYPVCP_UCARS,
	DIALOG_BUYPVCP_JOBCARS,
	DIALOG_BUYPVCP_VIPCARS,
	DIALOG_BUYPVCP_CONFIRM,
	DIALOG_BUYPVS_CONFIRM,
	DIALOG_BUYBOAT_CONFIRM,
	DIALOG_BUYPVCP_VIPCONFIRM,
	DIALOG_RENT_JOBCARS,
	DIALOG_RENT_JOBCARSCONFIRM,
	//job
	LIST_JOB,
	//---[ DIALOG TOYS ]---
	//Vehicle Toys
	DIALOG_VTOY,
	DIALOG_VTOYBUY,
	DIALOG_VTOYEDIT,
	DIALOG_VTOYPOSX,
	DIALOG_VTOYPOSY,
	DIALOG_VTOYPOSZ,
	DIALOG_VTOYPOSRX,
	DIALOG_VTOYPOSRY,
	DIALOG_VTOYPOSRZ,
	VSELECT_POS,
	VTOYSET_VALUE,
	VTOYSET_COLOUR,
	VTOY_ACCEPT,
	VENTOYSET_VALUE,
	VENSELECT_POS,
	//Player Toys
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
 	DIALOG_SCALEX,
 	DIALOG_SCALEY,
  	DIALOG_SCALEZ,
  	TSELECT_POS,
  	TOYSET_VALUE,
  	//butcher
  	D_WORK,
    D_WORK_INFO,
	//---[ DIALOG PLAYER ]---
	DIALOG_HELP,
	DIALOG_JOBHELP,
	DIALOG_GPS,
	DIALOG_GPS_FACTION,
	DIALOG_GPS_PROPERTY,
	DIALOG_GPS_PUBLIC,
	DIALOG_GPS_DEALERSHIP,
	DIALOG_GPS_PUBLISH,
	DIALOG_TRACKWS,
	DIALOG_TRACKPARK,
	DIALOG_FIND_DEALER,
	DIALOG_FIND_BISNIS,
	DIALOG_FIND_ATM,
	DIALOG_FIND_TREES,
	DIALOG_GPS_JOB,
	DIALOG_PAY,
	DIALOG_PAYBILL,
	DIALOG_TAKEHAULING,
	DIALOG_DYNAMICLIST,
	//---[GARKOT]---//
	DIALOG_PICKUPVEH,
	//---[ DIALOG WEAPONS ]---
	DIALOG_EDITBONE,
	//---[ DIALOG FAMILY ]---
	FAMILY_SAFE,
	FAMILY_STORAGE,
	FAMILY_WEAPONS,
	FAMILY_MARIJUANA,
	FAMILY_WITHDRAWMARIJUANA,
	FAMILY_DEPOSITMARIJUANA,
	FAMILY_COMPONENT,
	FAMILY_WITHDRAWCOMPONENT,
	FAMILY_DEPOSITCOMPONENT,
	FAMILY_MATERIAL,
	FAMILY_WITHDRAWMATERIAL,
	FAMILY_DEPOSITMATERIAL,
	FAMILY_MONEY,
	FAMILY_WITHDRAWMONEY,
	FAMILY_DEPOSITMONEY,
	FAMILY_INFO,
	//---[ DIALOG OWN FARM ]---
	FARM_STORAGE,
	FARM_INFO,
	FARM_POTATO,
	FARM_WHEAT,
	FARM_ORANGE,
	FARM_MONEY,
	FARM_DEPOSITPOTATO,
	FARM_WITHDRAWPOTATO,
	FARM_DEPOSITWHEAT,
	FARM_WITHDRAWWHEAT,
	FARM_DEPOSITORANGE,
	FARM_WITHDRAWORANGE,
	FARM_DEPOSITMONEY,
	FARM_WITHDRAWMONEY,
	//---[ DIALOG FACTION ]---
	DIALOG_LOCKERSAPD,
	DIALOG_WEAPONSAPD,
	DIALOG_LOCKERSAGS,
	DIALOG_WEAPONSAGS,
	DIALOG_LOCKERSAMD,
	DIALOG_WEAPONSAMD,
	DIALOG_LOCKERSANEW,
	DIALOG_WEAPONSANEW,
	DIALOG_LOCKERPEDAGANG,
	DIALOG_GUDANGPEDAGANG,

	DIALOG_LOCKERVIP,
	//---[ DIALOG JOB ]---
	//MECH
	DIALOG_SERVICE,
	DIALOG_SERVICE_COLOR,
	DIALOG_SERVICE_COLOR2,
	DIALOG_SERVICE_PAINTJOB,
	DIALOG_SERVICE_WHEELS,
	DIALOG_SERVICE_SPOILER,
	DIALOG_SERVICE_HOODS,
	DIALOG_SERVICE_VENTS,
	DIALOG_SERVICE_LIGHTS,
	DIALOG_SERVICE_EXHAUSTS,
	DIALOG_SERVICE_FRONT_BUMPERS,
	DIALOG_SERVICE_REAR_BUMPERS,
	DIALOG_SERVICE_ROOFS,
	DIALOG_SERVICE_SIDE_SKIRTS,
	DIALOG_SERVICE_BULLBARS,
	DIALOG_SERVICE_NEON,
	//Trucker
	DIALOG_HAULING,
	DIALOG_RESTOCK,
	DIALOG_CONTAINER,

	//ARMS Dealer
	DIALOG_ARMS_GUN,

	//Farmer job
	DIALOG_PLANT,
	DIALOG_EDIT_PRICE,
	DIALOG_EDIT_PRICE1,
	DIALOG_EDIT_PRICE2,
	DIALOG_EDIT_PRICE3,
	DIALOG_EDIT_PRICE4,
	DIALOG_OFFER,
	//----[ Items ]-----
	DIALOG_MATERIAL,
	DIALOG_COMPONENT,
	DIALOG_DRUGS,
	DIALOG_FOOD,
	DIALOG_FOOD_BUY,
	DIALOG_SEED_BUY,
	DIALOG_PRODUCT,
	DIALOG_GASOIL,
	DIALOG_APOTEK,
	//Bank
	DIALOG_ATM,
	DIALOG_ATMWITHDRAW,
	DIALOG_BANK,
	DIALOG_BANKDEPOSIT,
	DIALOG_BANKWITHDRAW,
	DIALOG_BANKREKENING,
	DIALOG_BANKTRANSFER,
	DIALOG_BANKCONFIRM,
	DIALOG_BANKSUKSES,
	//ask
	DIALOG_ASKS,

	//reports
	DIALOG_REPORTS,
	DIALOG_SALARY,
	DIALOG_PAYCHECK,

	//Sidejob
	DIALOG_TRASH,
	DIALOG_PIZZA,
	DIALOG_SWEEPER,
	DIALOG_BUS,
	DIALOG_FORKLIFT,
	//hauling tr
	//DIALOG_CHAULINGTR,
	//DIALOG_BUYTRUCK_CONFIRM,
	//DIALOG_HAULINGTR,

	DIALOG_PB,

	//gym
	DIALOG_FSTYLE,
	DIALOG_GMENU,
	//mods
	DIALOG_MMENU,
	//box
	DIALOG_TDC,
	DIALOG_TDC_PLACE,

	//event
	DIALOG_TDM,

	//veh control
	DIALOG_VC,
	//startjob
	DIALOG_WORK,
	//Phone
	DIALOG_ENTERNUM,
	NEW_CONTACT,
	CONTACT_INFO,
	CONTACT,
	DIAL_NUMBER,
	TEXT_MESSAGE,
	SEND_TEXT,
	SHARE_LOC,
	MY_PHONE,
	TWEET_APP,
	WHATSAPP_APP,
	TWEET_SIGNUP,
	TWEET_CHANGENAME,
	TWEET_ACCEPT_CHANGENAME,
	DIALOG_TWEETMODE,
	PHONE_NOTIF,
	PHONE_APP,
	PHONE_APP1,
	//trunk
	TRUNK_STORAGE,
	TRUNK_WEAPONS,
	TRUNK_MONEY,
	TRUNK_MARIJUANA,
	TRUNK_COMP,
	TRUNK_MATS,
	TRUNK_WITHDRAWMONEY,
	TRUNK_DEPOSITMONEY,
	TRUNK_WITHDRAWMARIJUANA,
	TRUNK_DEPOSITMARIJUANA,
	TRUNK_WITHDRAWCOMP,
	TRUNK_DEPOSITCOMP,
	TRUNK_WITHDRAWMATS,
	TRUNK_DEPOSITMATS,
	//mech
	DIALOG_MECH_LEVEL,

	//MDC
	DIALOG_TRACK,
	DIALOG_TRACK_PH,

	DIALOG_INFO_BIS,
	DIALOG_INFO_HOUSE,

	//bb
	DIALOG_BOOMBOX,
	DIALOG_BOOMBOX1,
}
//---[New]---
//DISCORD BOT
new DCC_Channel:g_Discord_AndroVerifed;
new DCC_Channel:g_discord_server;
new DCC_Channel:g_Discord_Kill;
new DCC_Channel:g_Discord_logswl;
new DCC_Channel:g_Discord_samp;
new DCC_Channel:g_discord_botcmd;
new DCC_Channel:g_discord_twt;
new DCC_Channel:g_discord_logs;
new DCC_Channel:g_discord_admins;
new DCC_Channel:g_discord_ban;
//TDM
new EventCreated = 0, EventStarted = 0, EventPrize = 500;
new Float: RedX, Float: RedY, Float: RedZ, EventInt, EventWorld;
new Float: BlueX, Float: BlueY, Float: BlueZ;
new EventHP = 100, EventArmour = 0, EventLocked = 0;
new EventWeapon1, EventWeapon2, EventWeapon3, EventWeapon4, EventWeapon5;
new BlueTeam = 0, RedTeam = 0;
new MaxRedTeam = 5, MaxBlueTeam = 5;
new IsAtEvent[MAX_PLAYERS];
new const Float:arrestPoints[][] =
{
    {224.11, 118.50, 999.10}
};

new Text:Cent[2];

//OTHER
new kick_gTimer[MAX_PLAYERS];

//ROB
new InRob[MAX_PLAYERS];
//BUTCHER
new playerobject[MAX_PLAYERS][2];
new meatsp;
new StoreMeat[MAX_PLAYERS];
//PILOT
new WorkBucks = 5000;
//new Penality = -650;

#define PH_D        4834
new TakingPs[MAX_PLAYERS] = 2;
///////////////CHECKPOINTS || LANDING OR TAKING////////////
new Float:RandomCPs[][3] =
{
	{1678.4602,-2625.2407,13.1195},   //LS
	{-1275.9586,10.1346,15.5220},   //SF
	{1347.2815,1281.2484,12.1943}, //LV
	{394.8399,2509.7869,17.8583}  //Desert
};
new rands;
new rands2;

//crack SetPlayerWeather(playerid, -68);

new cp[MAX_PLAYERS];

new Tflint[2];
new TollLv[2];
new pTollArea[4];
/////////VEHICLES || PLANES ////////////

new pilotvehs[9] =
{ 460, 511, 512, 513, 519, 553, 577, 592, 593 };

////////////////////////////////////////

//HAULING TRAILER
new bool:DialogHauling[10];
new TrailerHauling[MAX_PLAYERS];
new SedangHauling[MAX_PLAYERS];
new bool:DialogSaya[MAX_PLAYERS][10];

//[------ BACK FIRE ------]
enum ENUM_FIRE_INFO
{
	bool:fire_VALID,
	bool:fire_MIRROR,
	Float:fire_OFFSET_X,
	Float:fire_OFFSET_Y,
	Float:fire_OFFSET_Z,
	Float:fire_ROT_X,
	Float:fire_ROT_Y,
	Float:fire_ROT_Z
};
new FIRE_INFO[][ENUM_FIRE_INFO] =
{
	{true, false, 0.356599, -2.323499, -2.282700, 0.000000, 0.000000, 180.000000}, //400
	{true, false, 0.438600, -2.509499, -2.088700, 0.000000, 0.000000, 180.000000}, //401
	{true, true, 0.502600, -2.623499, -2.136700, 0.000000, 0.000000, 180.000000}, //402
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //403
	{true, false, 0.452600, -2.679299, -2.057499, 0.000000, 0.000000, 180.000000}, //404
	{true, false, 0.484899, -2.694099, -2.203500, 0.000000, 0.000000, 180.000000}, //405
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //406
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //407
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //408
	{true, false, 0.613099, -3.776700, -2.107199, 0.000000, 0.000000, 180.000000}, //409
	{true, false, 0.393799, -2.313999, -2.057199, 0.000000, 0.000000, 180.000000}, //410
	{true, true, 0.307799, -2.537999, -2.083199, 0.000000, 0.000000, 180.000000}, //411
	{true, false, 0.427300, -3.339999, -2.165199, 0.000000, 0.000000, 180.000000}, //412
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //413
	{true, false, 0.516099, -3.160899, -2.317199, 0.000000, 0.000000, 180.000000}, //414
	{true, true, 0.378100, -2.368799, -2.103199, 0.000000, 0.000000, 180.000000}, //415
	{true, false, 0.504199, -3.720499, -2.407199, 0.000000, 0.000000, 180.000000}, //416
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //417
	{true, false, 0.574599, -2.647899, -2.439199, 0.000000, 0.000000, 180.000000}, //418
	{true, false, 0.558099, -2.929099, -2.161200, 0.000000, 0.000000, 180.000000}, //419
	{true, false, 0.574100, -2.639099, -2.137199, 0.000000, 0.000000, 180.000000}, //420
	{true, false, 0.450100, -2.983999, -2.191200, 0.000000, 0.000000, 180.000000}, //421
	{true, false, 0.411700, -2.547899, -2.334000, 0.000000, 0.000000, 180.000000}, //422
	{true, false, -0.369800, -2.315999, -2.404000, 0.000000, 0.000000, 180.000000}, //423
	{true, true, 0.512099, -1.669300, -1.856099, 0.000000, 0.000000, 180.000000}, //424
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //425
	{true, false, 0.578000, -2.621899, -2.136100, 0.000000, 0.000000, 180.000000}, //426
	{true, false, 0.601499, -3.878599, -2.324200, 0.000000, 0.000000, 180.000000}, //427
	{true, false, 0.588999, -2.971599, -2.462199, 0.000000, 0.000000, 180.000000}, //428
	{true, true, 0.503000, -2.523599, -1.965199, 0.000000, 0.000000, 180.000000}, //429
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //430
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //431
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //432
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //433
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //434
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //435
	{true, false, 0.486999, -2.497599, -2.099299, 0.000000, 0.000000, 180.000000}, //436
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //437
	{true, false, 0.490399, -2.705899, -2.371700, 0.000000, 0.000000, 180.000000}, //438
	{true, true, 0.352400, -2.581899, -2.064399, 0.000000, 0.000000, 180.000000}, //439
	{true, false, 0.420700, -2.677599, -2.570899, 0.000000, 0.000000, 180.000000}, //440
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //441
	{true, false, 0.593100, -2.798699, -2.205100, 0.000000, 0.000000, 180.000000}, //442
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //443
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //444
	{true, false, 0.480199, -2.714699, -2.147099, 0.000000, 0.000000, 180.000000}, //445
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //446
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //447
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //448
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //449
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //450
	{true, false, 0.005400, -2.552699, -1.987100, 0.000000, 0.000000, 180.000000}, //451
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //452
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //453
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //454
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //455
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //456
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //457
	{true, false, 0.519200, -2.790499, -2.229899, 0.000000, 0.000000, 180.000000}, //458
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //459
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //460
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //461
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //462
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //463
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //464
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //465
	{true, false, 0.435200, -2.877399, -2.125900, 0.000000, 0.000000, 180.000000}, //466
	{true, false, 0.481200, -2.917399, -2.097899, 0.000000, 0.000000, 180.000000}, //467
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //468
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //469
	{true, false, -1.250200, -2.029500, -0.472800, 0.000000, 0.000000, 180.000000}, //470
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //471
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //472
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //473
	{true, true, 0.584999, -2.822599, -2.209800, 0.000000, 0.000000, 180.000000}, //474
	{true, false, 0.481000, -2.595699, -2.113800, 0.000000, 0.000000, 180.000000}, //475
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //476
	{true, false, 0.587000, -2.805699, -2.071799, 0.000000, 0.000000, 180.000000}, //477
	{true, false, 0.416700, -2.568699, -2.196799, 0.000000, 0.000000, 180.000000}, //478
	{true, false, 0.460799, -2.865999, -2.082799, 0.000000, 0.000000, 180.000000}, //479
	{true, false, 0.483300, -2.409999, -2.163700, 0.000000, 0.000000, 180.000000}, //480
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //481
	{true, false, 0.445899, -2.641699, -2.439800, 0.000000, 0.000000, 180.000000}, //482
	{true, false, -0.340600, -2.846899, -2.512400, 0.000000, 0.000000, 180.000000}, //483
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //484
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //485
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //486
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //487
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //488
	{true, false, 0.446500, -2.771499, -2.240900, 0.000000, 0.000000, 180.000000}, //489
	{true, false, 0.439999, -3.227299, -2.240900, 0.000000, 0.000000, 180.000000}, //490
	{true, false, 0.572200, -2.925899, -2.166899, 0.000000, 0.000000, 180.000000}, //491
	{true, false, 0.579599, -2.606400, -2.116899, 0.000000, 0.000000, 180.000000}, //492
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //493
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //494
	{true, false, 0.596599, -2.335199, -2.332799, 0.000000, 0.000000, 180.000000}, //495
	{true, false, 0.545400, -2.173599, -2.111700, 0.000000, 0.000000, 180.000000}, //496
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //497
	{true, false, -0.473800, -3.108199, -2.361400, 0.000000, 0.000000, 180.000000}, //498
	{true, false, 0.516200, -3.340600, -2.287400, 0.000000, 0.000000, 180.000000}, //499
	{true, false, 0.446900, -1.940299, -2.245399, 0.000000, 0.000000, 180.000000}, //500
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //501
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //502
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //503
	{true, false, 0.430299, -2.876699, -2.117300, 0.000000, 0.000000, 180.000000}, //504
	{true, false, 0.446299, -2.772699, -2.236900, 0.000000, 0.000000, 180.000000}, //505
	{true, true, 0.560599, -2.476300, -2.120100, 0.000000, 0.000000, 180.000000}, //506
	{true, false, 0.485199, -2.971699, -2.262000, 0.000000, 0.000000, 180.000000}, //507
	{true, false, 0.467400, -3.586999, -2.686900, 0.000000, 0.000000, 180.000000}, //508
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //509
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //510
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //511
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //512
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //513
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //514
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //515
	{true, false, 0.447800, -2.946699, -2.141499, 0.000000, 0.000000, 180.000000}, //516
	{true, false, 0.501800, -2.858699, -2.119499, 0.000000, 0.000000, 180.000000}, //517
	{true, false, -0.423400, -2.882499, -2.091500, 0.000000, 0.000000, 180.000000}, //518
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //519
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //520
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //521
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //522
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //523
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //524
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //525
	{true, false, 0.481799, -2.314099, -2.129499, 0.000000, 0.000000, 180.000000}, //526
	{true, false, 0.471799, -2.298099, -1.999199, 0.000000, 0.000000, 180.000000}, //527
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //528
	{true, false, -0.424699, -2.729899, -2.011199, 0.000000, 0.000000, 180.000000}, //529
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //530
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //531
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //532
	{true, true, 0.515100, -2.452399, -2.037100, 0.000000, 0.000000, 180.000000}, //533
	{true, true, 0.483099, -2.958400, -2.167099, 0.000000, 0.000000, 180.000000}, //534
	{true, true, 0.350600, -2.693499, -2.189100, 0.000000, 0.000000, 180.000000}, //535
	{true, true, 0.500000, -2.971299, -2.161099, 0.000000, 0.000000, 180.000000}, //536
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //537
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //538
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //539
	{true, false, -0.410600, -2.748699, -2.265599, 0.000000, 0.000000, 180.000000}, //540
	{true, true, 0.624000, -2.205999, -1.875100, 0.000000, 0.000000, 180.000000}, //541
	{true, false, 0.587400, -2.829499, -1.996899, 0.000000, 0.000000, 180.000000}, //542
	{true, false, -0.411000, -2.764599, -2.099200, 0.000000, 0.000000, 180.000000}, //543
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //544
	{true, true, 0.314900, -2.263700, -2.260600, 0.000000, 0.000000, 180.000000}, //545
	{true, false, 0.581200, -2.833499, -2.020299, 0.000000, 0.000000, 180.000000}, //546
	{true, false, 0.629199, -2.589499, -2.074300, 0.000000, 0.000000, 180.000000}, //547
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //548
	{true, false, 0.441300, -2.511600, -2.030299, 0.000000, 0.000000, 180.000000}, //549
	{true, false, -0.628300, -2.899799, -2.267199, 0.000000, 0.000000, 180.000000}, //550
	{true, false, 0.590799, -3.145499, -2.092799, 0.000000, 0.000000, 180.000000}, //551
	{true, false, 0.446900, -3.063399, -1.924800, 0.000000, 0.000000, 180.000000}, //552
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //553
	{true, false, 0.559300, -2.751999, -2.208499, 0.000000, 0.000000, 180.000000}, //554
	{true, true, 0.136000, -2.282899, -2.003200, 0.000000, 0.000000, 180.000000}, //555
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //556
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //557
	{true, true, 0.465799, -2.558699, -1.977200, 0.000000, 0.000000, 180.000000}, //558
	{true, true, 0.633099, -2.394599, -1.977200, 0.000000, 0.000000, 180.000000}, //559
	{true, true, 0.479999, -2.474699, -1.991199, 0.000000, 0.000000, 180.000000}, //560
	{true, true, 0.446200, -2.739599, -2.166300, 0.000000, 0.000000, 180.000000}, //561
	{true, true, 0.483300, -2.380199, -2.037100, 0.000000, 0.000000, 180.000000}, //562
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //563
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //564
	{true, false, 0.479299, -2.134199, -1.999099, 0.000000, 0.000000, 180.000000}, //565
	{true, false, 0.564700, -2.946699, -2.063100, 0.000000, 0.000000, 180.000000}, //566
	{true, false, 0.628700, -2.776700, -2.252900, 0.000000, 0.000000, 180.000000}, //567
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //568
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //569
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //570
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //571
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //572
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //573
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //574
	{true, false, 0.453399, -2.709800, -1.975300, 0.000000, 0.000000, 180.000000}, //575
	{true, false, 0.658100, -3.092499, -2.043299, 0.000000, 0.000000, 180.000000}, //576
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //577
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //578
	{true, false, -0.424600, -2.890699, -2.102699, 0.000000, 0.000000, 180.000000}, //579
	{true, false, -0.408600, -2.872699, -2.092700, 0.000000, 0.000000, 180.000000}, //580
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //581
	{true, false, 0.444999, -3.395499, -2.334199, 0.000000, 0.000000, 180.000000}, //582
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //583
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //584
	{true, false, -0.428999, -3.143299, -1.889299, 0.000000, 0.000000, 180.000000}, //585
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //586
	{true, true, 0.698000, -2.692600, -2.056400, 0.000000, 0.000000, 180.000000}, //587
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //588
	{true, false, 0.583999, -2.358599, -1.965899, 0.000000, 0.000000, 180.000000}, //589
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //590
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //591
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //592
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //593
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //594
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //595
	{true, false, 0.577000, -2.622299, -2.138499, 0.000000, 0.000000, 180.000000}, //596
	{true, false, 0.577000, -2.622299, -2.138499, 0.000000, 0.000000, 180.000000}, //597
	{true, false, 0.595000, -2.678299, -2.002500, 0.000000, 0.000000, 180.000000}, //598
	{true, false, 0.440600, -2.773699, -2.239099, 0.000000, 0.000000, 180.000000}, //599
	{true, false, 0.442600, -2.763700, -2.054199, 0.000000, 0.000000, 180.000000}, //600
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //601
	{true, true, 0.560999, -2.523999, -2.200700, 0.000000, 0.000000, 180.000000}, //602
	{true, true, 0.587000, -2.661999, -2.192699, 0.000000, 0.000000, 180.000000}, //603
	{true, false, 0.425700, -2.877099, -2.124700, 0.000000, 0.000000, 180.000000}, //604
	{true, false, -0.411900, -2.767699, -2.098700, 0.000000, 0.000000, 180.000000}, //605
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //606
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //607
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //608
	{true, false, -0.477699, -3.106199, -2.359499, 0.000000, 0.000000, 180.000000}, //609
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, //610
	{false, false, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000} //611
};

new
	bool:Player_Fire_Enabled[MAX_PLAYERS],
	Player_Key_Sprint_Time[MAX_PLAYERS];
// Countdown
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

// Server Uptime
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

//Model Selection
new SpawnMale = mS_INVALID_LISTID,
	SpawnFemale = mS_INVALID_LISTID,
	MaleSkins = mS_INVALID_LISTID,
	FemaleSkins = mS_INVALID_LISTID,
	VIPMaleSkins = mS_INVALID_LISTID,
	VIPFemaleSkins = mS_INVALID_LISTID,
	SAPDMale = mS_INVALID_LISTID,
	SAPDFemale = mS_INVALID_LISTID,
	SAPDWar = mS_INVALID_LISTID,
	SAGSMale = mS_INVALID_LISTID,
	SAGSFemale = mS_INVALID_LISTID,
	SAMDMale = mS_INVALID_LISTID,
	SAMDFemale = mS_INVALID_LISTID,
	SANEWMale = mS_INVALID_LISTID,
	SANEWFemale = mS_INVALID_LISTID,
	toyslist = mS_INVALID_LISTID,
	rentjoblist = mS_INVALID_LISTID,
	sportcar = mS_INVALID_LISTID,
	boatlist = mS_INVALID_LISTID,
	viptoyslist = mS_INVALID_LISTID,
	vtoylist = mS_INVALID_LISTID;


// Faction Vehicle
#define VEHICLE_RESPAWN 7200

new SAPDVehicles,
	SAGSVehicles[30],
	SAMDVehicles,
	SANAVehicles[30];

//flash for pd
#define flashtime 115
new Flash[MAX_VEHICLES];
new FlashTime[MAX_VEHICLES];

// Faction Vehicle
/*
IsSAPDCar(carid)
{
	for(new v = 0; v < sizeof(SAPDVehicles); v++)
	{
	    if(carid == SAPDVehicles) return 1;
	}
	return 0;
}
*/
IsGovCar(carid)
{
	for(new v = 0; v < sizeof(SAGSVehicles); v++)
	{
	    if(carid == SAGSVehicles[v]) return 1;
	}
	return 0;
}
/*
IsSAMDCar(carid)
{
	for(new v = 0; v < sizeof(SAMDVehicles); v++)
	{
	    if(carid == SAMDVehicles) return 1;
	}
	return 0;
}*/

IsSANACar(carid)
{
	for(new v = 0; v < sizeof(SANAVehicles); v++)
	{
	    if(carid == SANAVehicles[v]) return 1;
	}
	return 0;
}

//Showroom Checkpoint
new ShowRoomS,
	ShowRoomCp,
	ShowRoomCPRent;

new BoatDealer;

// Yom Button
new SAGSLobbyBtn[2],
	SAGSLobbyDoor,
	SAPDLobbyBtn[4],
	SAPDLobbyDoor[4],
	LLFLobbyBtn[2],
	LLFLobbyDoor;

new TogOOC = 1;
//----------[ Lumber Object Vehicle Job ]------------
#define MAX_LUMBERS 50
#define LUMBER_LIFETIME 100
#define LUMBER_LIMIT 10

enum    E_LUMBER
{
	// temp
	lumberDroppedBy[MAX_PLAYER_NAME],
	lumberSeconds,
	lumberObjID,
	lumberTimer,
	Text3D: lumberLabel
}
new LumberData[MAX_LUMBERS][E_LUMBER],
	Iterator:Lumbers<MAX_LUMBERS>;

new
	LumberObjects[MAX_VEHICLES][LUMBER_LIMIT];

new
	Float: LumberAttachOffsets[LUMBER_LIMIT][4] = {
	    {-0.223, -1.089, -0.230, -90.399},
		{-0.056, -1.091, -0.230, 90.399},
		{0.116, -1.092, -0.230, -90.399},
		{0.293, -1.088, -0.230, 90.399},
		{-0.123, -1.089, -0.099, -90.399},
		{0.043, -1.090, -0.099, 90.399},
		{0.216, -1.092, -0.099, -90.399},
		{-0.033, -1.090, 0.029, -90.399},
		{0.153, -1.089, 0.029, 90.399},
		{0.066, -1.091, 0.150, -90.399}
	};
new hydr[6];
enum E_HYDR_DATA
{
	H_NAME[120],
	Float: H_BAWAH[6],
	Float: H_ATAS[6],
};
/*
new h_hydr[6][E_HYDR_DATA] =
{
	{"Hydraulic 1\nType {34C924}/Hydraulic {ffffff}Or {34C924}/DHydraulic", {2193.24243, -2199.99780, 10.96290,   0.00000, 0.00000, 44.40000}, {2193.24243, -2199.99780, 11.52890,   0.33300, 0.00000, 44.40000}},
	{"Hydraulic 2\nType {34C924}/Hydraulic {ffffff}Or {34C924}/DHydraulic", {2199.55225, -2193.81885, 10.96290,   0.00000, 0.00000, 44.40000}, {2199.55225, -2193.81885, 11.52890,   0.00000, 0.00000, 44.40000}},
	{"Hydraulic 3\nType {34C924}/Hydraulic {ffffff}Or {34C924}/DHydraulic", {2186.67017, -2206.51807, 10.96290,   0.00000, 0.00000, 44.04000}, {2186.67017, -2206.51807, 11.52890,   0.00000, 0.00000, 44.04000}},
	{"Hydraulic 4\nType {34C924}/Hydraulic {ffffff}Or {34C924}/DHydraulic", {2201.54321, -2237.80566, 10.88290,   0.00000, 0.00000, -136.98000}, {2201.49927, -2237.76465, 11.46490,   0.00000, 0.00000, -136.98000}},
	{"Hydraulic 5\nType {34C924}/Hydraulic {ffffff}Or {34C924}/DHydraulic", {2208.19092, -2231.78809, 10.86690,   0.00000, 0.00000, -136.98000}, {2208.19092, -2231.78809, 11.43290,   0.00000, 0.00000, -136.98000}},
	{"Hydraulic 6\nType {34C924}/Hydraulic {ffffff}Or {34C924}/DHydraulic", {2214.58667, -2225.68530, 10.85890,   0.00000, 0.00000, -136.98000}, {2214.59106, -2225.65747, 11.42490,   0.00000, 0.00000, -136.98000}}
};*/
stock FIXES_valstr(dest[], value, bool:pack = false)
{
    // format can't handle cellmin properly
    static const cellmin_value[] = !"-2147483648";

    if (value == cellmin)
        pack && strpack(dest, cellmin_value, 12) || strunpack(dest, cellmin_value, 12);
    else
        format(dest, 12, "%d", value) && pack && strpack(dest, dest, 12);
}
stock number_format(number)
{
	new i, string[15];
	FIXES_valstr(string, number);
	if(strfind(string, "-") != -1) i = strlen(string) - 4;
	else i = strlen(string) - 3;
	while (i >= 1)
 	{
		if(strfind(string, "-") != -1) strins(string, ",", i + 1);
		else strins(string, ",", i);
		i -= 3;
	}
	return string;
}
stock PlayerFacePlayer( playerid, targetplayerid )
{
	new Float: Angle;
	GetPlayerFacingAngle( playerid, Angle );
	SetPlayerFacingAngle( targetplayerid, Angle+180 );
	return true;
}

stock AutoBan(playernya)
{
   new ban_time = gettime() + (5 * 86400), query[512], PlayerIP[16], giveplayer[24], string[5000];
   GetPlayerIp(playernya, PlayerIP, sizeof(PlayerIP));
   GetPlayerName(playernya, giveplayer, sizeof(giveplayer));

   SendClientMessageToAllEx(COLOR_BAN, "TwosixBot: Player %s Has Been Banned Permanently", giveplayer);
   SendClientMessageToAllEx(COLOR_BAN, "Reason: Cheating ");

   format(string, sizeof string, "```\nBanned: %s Has Benn Banned Permanently [Reason: Cheating]\n```",  giveplayer);
   DCC_SendChannelMessage(g_discord_ban, string);

   mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', 'Server Ban', 'Using Cheat!', %i, %d)", giveplayer, PlayerIP, gettime(), ban_time);
   mysql_tquery(g_SQL, query);
   KickEx(playernya);
}

stock SendMessageInChat(playerid, text[])
{
	new Float: x, Float: y, Float: z;
	new lstr[1024];

	GetPlayerPos(playerid, x, y, z);

	UpperToLower(text);
	format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
	ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
	SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
	text[0] = toupper(text[0]);
    /*if(!IsPlayerInAnyVehicle(playerid))
	 {
 	 	ApplyAnimation(playerid, "PED", "IDLE_chat", 4.100, 0, 1, 1, 1, 1, 1);
		SetTimerEx("ClearPlayerAnim", strlen(text) * 400, false, "i", playerid);
	 }*/
	return 1;
}

SaveLegacySystem(playerid)
{
	new file[256];
	format(file, sizeof(file), "Stats/%s.ini", pData[playerid][pName]);
	if(!dini_Exists(file)) return dini_Create(file);
	dini_IntSet(file, "PlayerCS", pData[playerid][pPlayerCS]);
	return 1;
}

LoadLegacySystem(playerid)
{
	new file[256];
	format(file, sizeof(file), "Stats/%s.ini", pData[playerid][pName]);
	pData[playerid][pPlayerCS] = dini_Int(file, "PlayerCS");
	return 1;
}

//Butcher
stock GoObject(playerid)
{
    playerobject[playerid][0] = CreateDynamicObject(2806, 942.3492, 2131.815185, 1011.226501, 0.000000, 0.000000, 0.000000, playerid+1, -1, -1, 300.00, 300.00);
	if(random(2))
	{
	    SetPVarInt(playerid,"BadMeat",1);
		SetDynamicObjectMaterial(playerobject[playerid][0], 0, 5421, "laesmokecnthus", "greenwall4", 0x00000000);
	}
	else DeletePVar(playerid,"BadMeat");
	MoveDynamicObject(playerobject[playerid][0],942.3492, 2123.890380, 1011.226501,2);
	Streamer_SetIntData(STREAMER_TYPE_OBJECT,playerobject[playerid][0],E_STREAMER_EXTRA_ID,playerid);
	Streamer_Update(playerid);

	return 1;
}

GetRPName(playerid)
{
	new
		name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, sizeof(name));

	for(new i = 0, l = strlen(name); i < l; i ++)
	{
	    if(name[i] == '_')
	    {
	        name[i] = ' ';
		}
	}

	return name;
}

GetPlayerNameEx(playerid)
{
	new name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock FixedKick(playerid)
{
    KillTimer(kick_gTimer[playerid]);
    kick_gTimer[playerid] = SetTimerEx("DelayedKick", 1000, false, "i", playerid);
    return 1;
}
stock GiveMoneyRob(playerid, small, big)
{
	new money;
	new moneys[100];
	money = small+random(big);
	pData[playerid][pRedMoney] += money;
	format(moneys, sizeof moneys, "You have succesfull Robery, Getting : {00FF7F}$%s", FormatMoney(money));
	SendClientMessage(playerid, 0xFFFFFF00, moneys);
}
stock SendTweetMessage(color, String[])
{
	foreach(new i : Player)
	{
		if(pData[i][pTogTweet] == 0)
		{
			SendClientMessageEx(i, color, String);
		}
	}
	return 1;
}
function FitnessTime(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			UpFitStats(playerid, playerid);
			ClearAnimations(playerid);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
function SpawnTimer(playerid)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pData[playerid][pMoney]);
	//GivePlayerCoint(playerid, pData[playerid][pLegCoint]);
	SetPlayerScore(playerid, pData[playerid][pLevel]);
	SetPlayerHealth(playerid, pData[playerid][pHealth]);
	pData[playerid][pSpawned] = 1;
	TogglePlayerControllable(playerid, 1);
	SetCameraBehindPlayer(playerid);
	AttachPlayerToys(playerid);
	SetWeapons(playerid);
	if(pData[playerid][pJail] > 0)
	{
		JailPlayer(playerid);
	}
	if(pData[playerid][pArrestTime] > 0)
	{
		SetPlayerArrest(playerid, pData[playerid][pArrest]);
	}
	return 1;
}
function SAGSLobbyDoorClose()
{
	MoveDynamicObject(SAGSLobbyDoor, 1389.375000, -25.387500, 999.978210, 3);
	return 1;
}

function SAPDLobbyDoorClose()
{
	MoveDynamicObject(SAPDLobbyDoor[0], 253.10965, 107.61060, 1002.21368, 3);
	MoveDynamicObject(SAPDLobbyDoor[1], 253.12556, 110.49657, 1002.21460, 3);
	MoveDynamicObject(SAPDLobbyDoor[2], 239.69435, 116.15908, 1002.21411, 3);
	MoveDynamicObject(SAPDLobbyDoor[3], 239.64050, 119.08750, 1002.21332, 3);
	return 1;
}

function LLFLobbyDoorClose()
{
	MoveDynamicObject(LLFLobbyDoor, -2119.21509, 657.54187, 1060.73560, 3);
	return 1;
}
function ForkliftTake(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			TogglePlayerControllable(playerid, 1);

			SetPVarInt(playerid, "box", CreateDynamicObject(2912,0,0,0,0,0,0));
			AttachDynamicObjectToVehicle(GetPVarInt(playerid, "box"), GetPlayerVehicleID(playerid), -0.10851, 0.62915, 0.87082, 0.0, 0.0, 0.0);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
function ContainerTake(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 5;
			TogglePlayerControllable(playerid, 1);

			SetPVarInt(playerid, "container", CreateDynamicObject(2935,0,0,0,0,0,0));
			AttachDynamicObjectToVehicle(GetPVarInt(playerid, "container"), GetPlayerVehicleID(playerid), 0.000, -1.009, 1.090, 0.000, 0.000, 0.000);
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
function FillElectric(playerid)
{
	if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			TogglePlayerControllable(playerid, 1);

			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
function ForkliftDown(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 3;
			TogglePlayerControllable(playerid, 1);
			DestroyDynamicObject(GetPVarInt(playerid, "box"));
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
function ContainerDown(playerid)
{
    if(!IsValidTimer(pData[playerid][pActivity])) return 0;
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			InfoTD_MSG(playerid, 8000, "Done!");
			KillTimer(pData[playerid][pActivity]);
			pData[playerid][pActivityTime] = 0;
			HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
			PlayerTextDrawHide(playerid, ActiveTD[playerid]);
			pData[playerid][pEnergy] -= 5;
			TogglePlayerControllable(playerid, 1);
			DestroyDynamicObject(GetPVarInt(playerid, "container"));
			return 1;
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			pData[playerid][pActivityTime] += 5;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		}
	}
	return 1;
}
ServerLabels()
{
	new strings[128];
	CreateDynamicPickup(1239, 23, 1252.8046,-1286.8199,1061.1492, -1);
	format(strings, sizeof(strings), "[TREATMENT]\n{FFFFFF}/treatment\nMenghilangkan Sakit atau Penglihatan Merah\nPrice: $3.000");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1252.8046,-1286.8199,1061.1492, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Treatement

	CreateDynamicPickup(1239, 23, 2108.7407,-1785.5049,13.3868, -1);
	format(strings, sizeof(strings), "[PIZZA JOB]\n{FFFFFF}/getpizza\nAmbil pizza lalu Antarkan Kesetiap Rumah\nGunakan Motor Pizza");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2108.7407,-1785.5049,13.3868, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Pizza

	CreateDynamicPickup(1239, 23, 1599.85,-1708.79,6.19063, -1);
	format(strings, sizeof(strings), "[SAPD VEHICLE]\n{FFFFFF}/pdpv\n Vehicle For Sapd");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1599.85,-1708.79,6.19063, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //Veh Sapd

	CreateDynamicPickup(1239, 23, 1132.24, -1334.37, 14.2844, -1);
	format(strings, sizeof(strings), "[SAMD VEHICLE]\n{FFFFFF}/mdpv\n Vehicle For Samd");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1132.24, -1334.37, 14.2844, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // veh faction

	CreateDynamicPickup(1239, 23, 1370.6390,717.5485,-15.7573, -1);
	format(strings, sizeof(strings), "[BPJS]\n{FFFFFF}/newbpjs\n mendapatkan BPJS");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1370.6390,717.5485,-15.7573, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bpjs

	CreateDynamicPickup(1239, 23, 1345.3302,-1763.2202,13.5992, -1);
	format(strings, sizeof(strings), "[Spray Tags]\n{FFFFFF}/buy");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1345.3302,-1763.2202,13.5992, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // tags

	CreateDynamicPickup(2912, 23, -383.0497,-1438.9336,26.3277, -1);
	format(strings, sizeof(strings), "[CARGO]\n{FFFFFF}/cargo sell\n sell cargo");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2790.7275,-2417.8015,13.6329, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card

	CreateDynamicPickup(1239, 23, 1392.77, -22.25, 1000.97, -1);
	format(strings, sizeof(strings), "[City Hall]\n{FFFFFF}/newidcard - create new ID Card\n/newage - Change Birthday\n/sellhouse - sell your house\n/sellbisnis - sell your bisnis");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1392.77, -22.25, 1000.97, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card

	CreateDynamicPickup(1239, 23, 686.5079, -1570.8524, 14.2781, -1);
	format(strings, sizeof(strings), "[Veh Insurance]\n{FFFFFF}/buyinsu - buy insurance\n/claimpv - claim insurance\n/sellpv - sell vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 686.5079, -1570.8524, 14.2781, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	CreateDynamicPickup(1239, 23, 604.0515, -1509.5780, 14.9621, -1);
	format(strings, sizeof(strings), "[VEHICLE INSURANCE]\n{FFFFFF}Vehicle Insurance Spawn");
	CreateDynamic3DTextLabel(strings, COLOR_AQUA, 604.0515, -1509.5780, 14.9621, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	CreateDynamicPickup(1239, 23, 1081.2939,-1696.7833,13.5469, -1);
	format(strings, sizeof(strings), "[License]\n{FFFFFF}/newdrivelic - create new license driving");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1081.2939,-1696.7833,13.5469, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic

	CreateDynamicPickup(1239, 23, 655.738525, 2543.672851, -89.455139, -1);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 655.738525, 2543.672851, -89.455139, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate

	CreateDynamicPickup(1239, 23, 1560.42, -1672.39, 2113.33, -1);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket\n/buyplate - to buy plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 1560.42, -1672.39, 2113.33, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket

	for(new i = 0; i < sizeof(arrestPoints); i ++)
	{
	    CreateDynamic3DTextLabel("[ARREST POINT]\n{FFFFFF}/arrest - arrest wanted player and /release to release suspect", COLOR_GREY, arrestPoints[i][0], arrestPoints[i][1], arrestPoints[i][2], 7.0);
	    CreateDynamicPickup(1247, 1, arrestPoints[i][0], arrestPoints[i][1], arrestPoints[i][2]);
	} // arrest

	CreateDynamicPickup(1239, 23, 1142.38, -1330.74, 13.62, -1);
	format(strings, sizeof(strings), "[Hospital]\n{FFFFFF}/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_PINK, 1142.38, -1330.74, 13.62, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital

	CreateDynamicPickup(1239, 23, 2246.46, -1757.03, 1014.77, -1);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/newrek - create new rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LOGS, 2246.46, -1757.03, 1014.77, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank

	CreateDynamicPickup(1239, 23, 2246.55, -1750.25, 1014.77, -1);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/bank - access rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LOGS, 2246.55, -1750.25, 1014.77, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank

	CreateDynamicPickup(1239, 23, 2461.21, 2270.42, 91.67, -1);
	format(strings, sizeof(strings), "[Ads]\n{FFFFFF}/ads - public ads");
	CreateDynamic3DTextLabel(strings, COLOR_LOGS, 2461.21, 2270.42, 91.67, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	CreateDynamicPickup(1239, 23, 1254.7303, -2059.5728, 59.5827, -1);
	format(strings, sizeof(strings), "[Payphone]\n{FFFFFF}/cu - $5");
	CreateDynamic3DTextLabel(strings, COLOR_LOGS, 1254.7303, -2059.5728,59.5827 , 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // cu

	CreateDynamicPickup(1239, 23, 1773.6583, -1015.3002, 23.9609, -1);
	format(strings, sizeof(strings), "[Payphone]\n{FFFFFF}/cu - $5");
	CreateDynamic3DTextLabel(strings, COLOR_LOGS, 1773.6583, -1015.3002, 23.9609 , 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // cu

	//meat
	CreateDynamicPickup(1239, 23, 942.3542, 2117.8999, 1011.0303, -1, -1, -1, 5.0);
	format(strings, sizeof(strings), "["YELLOW_E"Store Meat"WHITE_E"]\n"WHITE_E"You can store "LG_E"10"WHITE_E" meat\nand\nselect spoiled pieces\n\n"LB_E"/storemeat");
	CreateDynamic3DTextLabel(strings, COLOR_WHITE, 942.3542, 2117.8999, 1011.0303, 5.0);

	CreateDynamicPickup(1239, 23, 83.5759, -187.7058, 1.5411, -1);
	format(strings, sizeof(strings), "{00FFFF}[BOX SELL]\n{FFFF00}Cargo Box: {FFFFFF}Sell\n\n{00FFFF}/cargo sell - for sell");
	CreateDynamic3DTextLabel(strings, COLOR_LOGS, 83.5759, -187.7058, 1.5411, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	//Dynamic CP
	BoatDealer = CreateDynamicCP(131.4477,-1804.2656, 4.3699, 1.0, -1, -1, -1, 5.0);
	CreateDynamic3DTextLabel("Buy Boat", COLOR_GREEN, 131.4477,-1804.2656, 4.3699, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);

	ShowRoomS = CreateDynamicCP(1259.93, -1543.91, 13.7946, 1.0, 0, 0, 0, 5.0);
	CreateDynamic3DTextLabel("Buy Vip Vehicle", COLOR_GOLD, 1259.93, -1543.91, 13.7946, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);

	ShowRoomCp = CreateDynamicCP(1254.37, -1542.64, 13.7946, 1.0, 0, 0, 0, 5.0);
	CreateDynamic3DTextLabel("Buy Vehicle", COLOR_GREEN, 1254.37, -1542.64, 13.7946, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);

	ShowRoomCPRent = CreateDynamicCP(1259.1423, -1262.9587, 13.5234, 1.0, -1, -1, -1, 5.0);
	CreateDynamic3DTextLabel("Rental Vehicle\n"YELLOW_E"/unrentpv", COLOR_LBLUE, 1259.1423, -1262.9587, 13.5234, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
}

forward EnterBisnis(playerid);
forward EnterHouse(playerid);
forward EnterDoor(playerid);
forward F1CloseToll(playerid);
forward F2CloseToll(playerid);
forward LV1CloseToll(playerid);
forward LV2CloseToll(playerid);
forward ClearPlayerAnim(playerid);
forward DCC_OnMessageCreate(DCC_Message:message);
forward DelayedKick(playerid);
forward FillTrash(id);

//Close Toll

public F1CloseToll(playerid)
{
	SetDynamicObjectRot(Tflint[0], 0.000000, -90.000000, 270.67565917969);
	return 1;
}
public F2CloseToll(playerid)
{
	SetDynamicObjectRot(Tflint[1], 0.000000, -90.000000, 87.337799072266);
	return 1;
}
public LV1CloseToll(playerid)
{
	SetDynamicObjectRot(TollLv[0], 0.000000, -90.000000, 348.10229492188);
	return 1;
}
public LV2CloseToll(playerid)
{
	SetDynamicObjectRot(TollLv[1], 0.000000, -90.000000, 169.43664550781);
	return 1;
}
public ClearPlayerAnim(playerid)
{
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

public DCC_OnMessageCreate(DCC_Message:message)
{
	new realMsg[100], msg[128];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:channel;
 	DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
	DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == g_Discord_AndroVerifed && !IsBot)
    {
    	new player[200];
    	format(player,sizeof(player),"Whitelist/%s.txt",realMsg);
    	{
			if(!dini_Exists(player))
  			{
      			dini_Create(player);
    			format(msg, sizeof(msg), "```\nName: %s Telah Terverifikasi Di Whitelist!\n```",realMsg);
    			DCC_SendChannelMessage(g_Discord_logswl, msg);
			}
  			else
    		{
    			format(msg, sizeof(msg), "Akun ini Sudah **diverifikasi tadi!**");
    			DCC_SendChannelMessage(g_Discord_AndroVerifed, msg);
      		}
   		}
    }
    if(channel == g_Discord_samp && !IsBot)
    {
		new DCC_Role:WARGA, DCC_Guild:guild;
        WARGA = DCC_FindRoleById("920570929283727380"); //ID Role
        DCC_AddGuildMemberRole(guild, author, WARGA);
        format(msg, sizeof(msg), "__**Accept**__");
    	DCC_SendChannelMessage(g_Discord_samp, msg);
	}
	if(channel == g_discord_botcmd && !IsBot) //!IsBot will block BOT's message in game
	{
        if(!strcmp(realMsg, "/players", true))
        {
        	format(msg, sizeof(msg), ":emoji_56-1: **Jumlah Pemain Online Saat Ini: %d**", Iter_Count(Player));
	    	DCC_SendChannelMessage(g_discord_botcmd, msg);
	    }
	}
    return 1;
}

public DelayedKick(playerid)
{
    if (!IsPlayerConnected(playerid)) return 1;
    Kick(playerid);
    return 1;
}

//---------[ Ores miner Job Log ]-------
#define LOG_LIFETIME 100
#define LOG_LIMIT 10
#define MAX_LOG 100

enum    E_LOG
{
	// temp
	bool:logExist,
	logType,
	logDroppedBy[MAX_PLAYER_NAME],
	logSeconds,
	logObjID,
	logTimer,
	Text3D:logLabel
}
new LogData[MAX_LOG][E_LOG];

new
	LogStorage[MAX_VEHICLES][2];

//------[ Trucker ]--------

new VehProduct[MAX_VEHICLES];
new VehGasOil[MAX_VEHICLES];

//-----[ Include Modular ]-----
main()
{
	SetTimer("onlineTimer", 1000, true);
	SetTimer("TDUpdates", 8000, true);
	SetTimer_("OnMinuteTimer", 60000,0,-1);
	SetTimer_("OnSecondTimer", 1000, 0, -1);
}
#include "MODULE\MODULAR.pwn"
#include "MODULE\ANIMS.pwn"
#include "MODULE\VOTE.pwn"
#include "MODULE\BERRY.pwn"
#include "MODULE\ACTOR.pwn"
#include "MODULE\ARREST.pwn"
#include "MODULE\QUIZ.pwn"
#include "MODULE\REPORT.pwn"
#include "MODULE\ASK.pwn"
#include "MODULE\WEAPON_ATTH.pwn"
#include "MODULE\TOYS.pwn"
#include "MODULE\GRAFITY.pwn"
#include "MODULE\PB.pwn"
#include "MODULE\PHONE.pwn"
#include "MODULE\HELMET.pwn"
#include "MODULE\SERVER.pwn"
#include "MODULE\DOOR.pwn"
#include "MODULE\FAMILY.pwn"
#include "MODULE\HOUSE.pwn"
#include "MODULE\GARAGE.pwn"
#include "MODULE\PRIVATE_VEHICLE.pwn"
#include "MODULE\VEHICLE_TOYS.pwn"
#include "MODULE\BISNIS.pwn"
#include "MODULE\AUCTION.pwn"
#include "MODULE\BILLS.pwn"
#include "MODULE\FARM.pwn"
#include "MODULE\WORKSHOP.pwn"
#include "MODULE\MAPPING.pwn"
#include "MODULE\COBJECT.pwn"
#include "MODULE\GAS_STATION.pwn"
#include "MODULE\DYNAMIC_LOCKER.pwn"
#include "MODULE\NATIVE.pwn"
#include "MODULE\JOB\JOB_SWEEPER.pwn"
#include "MODULE\JOB\JOB_BUS.pwn"
#include "MODULE\JOB\JOB_PIZZA.pwn"
#include "MODULE\GYM.pwn"
#include "MODULE\MODSHOP.pwn"
#include "MODULE\JOB\JOB_FORKLIFT.pwn"
#include "MODULE\JOB\JOB_BOX.pwn"
#include "MODULE\JOB\JOB_COURIER.pwn"
#include "MODULE\JOB\JOB_TRASHMASTER.pwn"
#include "MODULE\VOUCHER.pwn"
#include "MODULE\SALARY.pwn"
#include "MODULE\ATM.pwn"
#include "MODULE\DMV.pwn"
#include "MODULE\VENDING.pwn"
#include "MODULE\DEALER.pwn"
#include "MODULE\ARMS_DEALER.pwn"
#include "MODULE\GATE.pwn"
#include "MODULE\EVENT.pwn"
#include "MODULE\MDC.pwn"
#include "MODULE\JOB\JOB_TAXI.pwn"
#include "MODULE\JOB\JOB_MECH.pwn"
#include "MODULE\JOB\JOB_LUMBER.pwn"
#include "MODULE\JOB\JOB_MINER.pwn"
#include "MODULE\JOB\JOB_PRODUCTION.pwn"
#include "MODULE\JOB\JOB_TRUCKER.pwn"
#include "MODULE\JOB\JOB_FISH.pwn"
#include "MODULE\JOB\JOB_FARMER.pwn"
#include "MODULE\JOB\JOB_ELECTRIC.pwn"
#include "MODULE\JOB\JOB_DRUG_SMUGGLER.pwn"
#include "MODULE\CMD\ADMIN.pwn"
#include "MODULE\CMD\FACTION.pwn"
#include "MODULE\CMD\PLAYER.pwn"
#include "MODULE\CMD\DISCORD.pwn"
#include "MODULE\SAPD_TASER.pwn"
#include "MODULE\SAPD_SPIKE.pwn"
#include "MODULE\CONTACT.pwn"
#include "MODULE\VSTORAGE.pwn"
#include "MODULE\UCP.pwn"
#include "MODULE\DIALOG.pwn"
#include "MODULE\APARTEMENT.pwn"
#include "MODULE\CMD\ALIAS\ALIAS_ADMIN.pwn"
#include "MODULE\CMD\ALIAS\ALIAS_PLAYER.pwn"
#include "MODULE\CMD\ALIAS\ALIAS_BISNIS.pwn"
#include "MODULE\CMD\ALIAS\ALIAS_HOUSE.pwn"
#include "MODULE\CMD\ALIAS\ALIAS_PRIVATE_VEHICLE.pwn"
#include "MODULE\FUNCTION.pwn"
#include "MODULE\ROBBERY.pwn"
#include "MODULE\ANTIAIMBOT.pwn"

function AutoGmx()
{
	SetTimer("GmxNya", 60000, true);
	SendClientMessageToAll(COLOR_RED, "[Auto Gmx]"WHITE_E" - Server akan otomatis restar dalam "RED_E"60"WHITE_E" detik");
	//DCC_SendChannelMessage(g_Discord_Information, "```Server akan otomatis __Restar__ Dalam 60 detik```.");
	return 1;
}
function GmxNya()
{
	SendRconCommand("gmx");
}

public EnterDoor(playerid)
{
	if(IsPlayerConnected(playerid))
	foreach(new did : Doors)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
		{
			return 1;
		}
	}
	return 0;
}

public EnterBisnis(playerid)
{
	if(IsPlayerConnected(playerid))
	foreach(new id : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[id][bIntposX], bData[id][bIntposY], bData[id][bIntposZ]))
		{
			return 1;
		}
	}
	return 0;
}

public EnterHouse(playerid)
{
	if(IsPlayerConnected(playerid))
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.8, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.8, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ]))
		{
			return 1;
		}
	}
	return 0;
}

public OnGameModeInit()
{
	//mysql_log(ALL);
	SetTimer("Stats", 1000, true);
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("");
		return 1;
	}
	print("MySQL connection is successful.");

	mysql_tquery(g_SQL, "SELECT * FROM `server`", "LoadServer");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `farm`", "LoadFarm");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "LoadWorkshop");
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `vouchers`", "LoadVouchers");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	mysql_tquery(g_SQL, "SELECT * FROM `ores`", "LoadOres");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `vending`", "LoadVending");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `dealership`", "LoadDealership");
	mysql_tquery(g_SQL, "SELECT * FROM `berry`", "LoadBerry");
	mysql_tquery(g_SQL, "SELECT * FROM `trunk`", "LoadVehicleStorage");
	mysql_tquery(g_SQL, "SELECT * FROM `arrestpoints", "LoadARR");
	//------- siren
	for(new x=0; x<MAX_VEHICLES; x++)
	{
		Flasher[x] = 0;
		FlasherState[x] = 0;
	}
	FlashTimer = SetTimer("FlasherFunc", 200, 1);
	//--------
	new gm[32];
	format(gm, sizeof(gm), "%s", TEXT_GAMEMODE);
	SetGameModeText(gm);
	format(gm, sizeof(gm), "weburl %s", TEXT_WEBURL);
	SendRconCommand(gm);
	format(gm, sizeof(gm), "language %s", TEXT_LANGUAGE);
	SendRconCommand(gm);
	//---- [ Function ]----
	CreateTextDraw();
	CreateServerPoint();
	CreateJoinLumberPoint();
	CreateJoinTaxiPoint();
	CreateJoinMechPoint();
	CreateJoinMinerPoint();
	CreateJoinProductionPoint();
	CreateJoinTruckPoint();
	CreateArmsPoint();
	CreateJoinFarmerPoint();
	CreateJoinSmugglerPoint();
	CreateJoinKurirPoint();
	LoadTazerSAPD();
	//server
	ServerLabels();
	ServerVehicle();
	LoadFarm();
	//Sidejob Vehicle
	AddSweeperVehicle();
	AddPizzaVehicle();
	AddBusVehicle();
	AddForVehicle();
	AddTrashVehicle();
	AddKurirVehicle();
	//DMV Veh
	AddDmvVehicle();
	//map
	ObjectMapping();
	LoadObjects();
	LoadGym();
	LoadGYMObject();
	LoadModsPoint();
	LoadActors();
	//---
	SendRconCommand("mapname San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	SetNameTagDrawDistance(20.0);

	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	BlockGarages(.text=".");

	//Timer
	SetTimer("settime",1000,true);
	//SetTimer("CheckPlayers",1000,true);
	//_____-txtAnimHelper___/
	txtAnimHelper = TextDrawCreate(630.0, 420.0,
	"~r~~k~~GROUP_CONTROL_BWD~ ~w~to stop the animation");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0);
    TextDrawSetOutline(txtAnimHelper,1);
    TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
    TextDrawColor(txtAnimHelper,0xFFFFFFFF);
    TextDrawAlignment(txtAnimHelper,3);
	//---- [ Other ]----//
	CreateDynamicObject(987, 831.75732, -519.75250, 15.43560,   0.00000, -2.00000, 90.00000);
	CreateDynamicObject(987, 831.66217, -507.75879, 15.86480,   2.00000, -2.00000, 90.00000);
	CreateDynamicObject(987, 831.74219, -495.97000, 16.26480,   2.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 831.74933, -494.54861, 16.26480,   2.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 811.41632, -519.99298, 15.26480,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 819.87091, -482.68771, 16.22480,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(987, 818.60474, -482.67953, 16.22480,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(987, 806.74170, -482.66019, 16.22480,   0.00000, 0.00000, -89.00000);
	CreateDynamicObject(987, 806.91779, -494.57001, 16.22480,   0.00000, 0.00000, -91.00000);
	CreateDynamicObject(987, 806.74719, -507.94949, 16.08480,   0.00000, 4.00000, -89.00000);
	CreateDynamicObject(987, 806.70758, -506.13403, 16.20480,   0.00000, 4.00000, -89.00000);
	CreateDynamicObject(987, 831.85498, -482.68753, 16.24480,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(987, 806.91943, -519.98999, 15.26480,   0.00000, 0.00000, 0.00000);
	//int ms13
	CreateObject(19378, 2192.12988, -1243.15002, 1528.02002,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19378, 2202.62988, -1243.15002, 1528.02002,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19378, 2192.12988, -1252.78003, 1528.02002,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19365, 2189.04004, -1243.50000, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19394, 2192.25000, -1243.50000, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19394, 2194.92993, -1244.60999, 1529.87000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(19378, 2202.62988, -1252.78003, 1528.02002,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19365, 2187.54004, -1246.19995, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19394, 2190.75000, -1246.19995, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19438, 2192.86011, -1246.73999, 1529.87000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(19365, 2193.39990, -1252.05005, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19394, 2193.39990, -1255.23999, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2187.37012, -1244.63000, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2196.04004, -1247.29004, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19459, 2193.80005, -1238.64001, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19456, 2188.62012, -1253.65002, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19395, 2190.73999, -1246.20996, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19367, 2187.54004, -1246.20996, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19440, 2192.85010, -1246.75000, 1529.87000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(19367, 2193.38989, -1252.05005, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19459, 2187.20996, -1248.87000, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(17969, 2190.30005, -1253.53003, 1530.12000,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1502, 2189.96997, -1246.22998, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 2194.36011, -1244.06995, 1528.09998,   0.00000, 0.00000, -45.00000);
	CreateDynamicObject(1502, 2191.45996, -1243.52002, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2236, 2190.14990, -1251.20996, 1528.09998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1756, 2187.86011, -1251.44995, 1528.10999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1711, 2189.13989, -1248.58997, 1528.09998,   0.00000, 0.00000, 7.00000);
	CreateDynamicObject(1712, 2191.42993, -1249.81006, 1528.09998,   0.00000, 0.00000, -94.00000);
	CreateDynamicObject(2313, 2190.13989, -1253.21997, 1528.09998,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2648, 2189.12988, -1253.23999, 1528.85999,   0.00000, 0.00000, 176.00000);
	CreateDynamicObject(1719, 2189.85010, -1253.18005, 1528.62000,   0.00000, 0.00000, 183.00000);
	CreateDynamicObject(1510, 2189.85010, -1251.06006, 1528.62000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2959, 2193.45996, -1255.97998, 1528.10999,   0.00000, 0.00000, 80.00000);
	CreateDynamicObject(2104, 2188.79004, -1246.21997, 1528.07996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2229, 2189.78003, -1246.30005, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2229, 2187.97998, -1246.30005, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14840, 2189.73999, -1243.58997, 1529.76001,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18661, 2195.93994, -1247.09998, 1530.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2194.81006, -1256.77002, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19365, 2196.04004, -1256.91003, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19394, 2196.04004, -1250.50000, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19354, 2197.72998, -1249.40002, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 2197.72998, -1251.54004, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19384, 2200.93994, -1249.40002, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 2200.93994, -1251.54004, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 2204.14990, -1251.54004, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 2204.14990, -1249.40002, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19354, 2204.27002, -1250.27002, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19384, 2196.05005, -1250.51001, 1529.85999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19365, 2197.56006, -1245.67004, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19457, 2198.65991, -1238.41003, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19397, 2200.92993, -1249.39001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19369, 2197.72998, -1249.39001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19369, 2204.13989, -1249.39001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19369, 2196.06006, -1247.69995, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19369, 2197.72998, -1246.01001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19369, 2199.25000, -1244.48999, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19461, 2203.98999, -1242.89001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19461, 2204.26001, -1244.52002, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 2200.13989, -1249.42004, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19459, 2187.39990, -1238.64001, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19456, 2189.05005, -1238.39001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(4227, 2198.12012, -1251.54004, 1529.85999,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18663, 2193.50000, -1250.91003, 1529.76001,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19393, 2193.38989, -1255.22998, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19456, 2188.62012, -1256.76001, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19364, 2187.20996, -1255.30005, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19457, 2199.06006, -1240.91003, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19457, 2193.81006, -1238.64001, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19367, 2189.03003, -1243.48999, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19395, 2192.23999, -1243.48999, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(4227, 2201.61011, -1238.39001, 1529.85999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14880, 2197.67993, -1244.09998, 1528.50000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14556, 2197.76001, -1239.53003, 1529.62000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2394, 2197.93994, -1238.92004, 1529.48999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2372, 2198.60010, -1239.12000, 1530.98999,   0.00000, 180.00000, 90.00000);
	CreateDynamicObject(2323, 2194.86011, -1239.98999, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2835, 2195.82007, -1242.01001, 1528.09998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2845, 2197.76001, -1242.07996, 1528.10999,   0.00000, 0.00000, 20.00000);
	CreateDynamicObject(2659, 2198.97998, -1243.70996, 1530.07996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2693, 2197.19995, -1245.76001, 1530.29004,   10.00000, 4.00000, 180.00000);
	CreateDynamicObject(2695, 2193.91992, -1241.08997, 1530.19995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1529, 2193.89990, -1240.33997, 1530.12000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2691, 2193.32007, -1251.47998, 1529.90002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2270, 2192.45996, -1247.18005, 1530.39001,   0.00000, 0.00000, -45.00000);
	CreateDynamicObject(2069, 2192.76001, -1253.01001, 1528.14001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3034, 2187.30005, -1249.91003, 1530.12000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3034, 2187.48999, -1240.76001, 1530.12000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3034, 2196.92993, -1238.50000, 1530.12000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19394, 2196.04004, -1253.70996, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19459, 2200.90991, -1255.59998, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19367, 2196.05005, -1256.90002, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19395, 2196.05005, -1253.69995, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19459, 2200.90991, -1252.03003, 1529.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19459, 2200.37988, -1256.58997, 1529.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2201.30005, -1256.80005, 1528.03003,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(1502, 2196.02002, -1252.92004, 1528.09998,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(3034, 2198.15991, -1255.51001, 1530.12000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2525, 2196.84009, -1254.96997, 1528.12000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2526, 2199.87988, -1255.05005, 1528.10999,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2518, 2198.35010, -1252.63000, 1528.22998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2836, 2198.71997, -1254.44995, 1528.10999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2846, 2197.41992, -1254.20996, 1528.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2414, 2196.61011, -1252.43005, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2306, 2199.73999, -1253.62000, 1528.12000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14840, 2199.39990, -1257.06995, 1530.18005,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2135, 2201.69995, -1243.47998, 1528.08997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2138, 2202.68994, -1243.48999, 1528.08997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2303, 2200.69995, -1243.47998, 1528.08997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2305, 2203.66992, -1243.48999, 1528.08997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2305, 2199.75000, -1243.48999, 1528.08997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2136, 2199.75000, -1245.47998, 1528.08997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2138, 2203.66992, -1244.45996, 1528.08997,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2138, 2203.66992, -1245.43994, 1528.08997,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(5375, 1993.91003, -2064.35010, 18.53000,   356.85999, 0.00000, 3.14000);
	CreateDynamicObject(5375, 2121.32007, -1272.81995, 1534.87000,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1575, 2187.60010, -1253.94995, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, 2188.14990, -1253.94995, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, 2187.50000, -1254.40002, 1528.09998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1575, 2187.50000, -1254.93994, 1528.09998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1575, 2188.68994, -1253.94995, 1528.09998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, 2187.90991, -1253.94995, 1528.23999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, 2188.46997, -1253.94995, 1528.23999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1575, 2187.50000, -1254.16003, 1528.23999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1575, 2187.50000, -1254.71997, 1528.23999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1575, 2187.94995, -1254.80005, 1528.09998,   0.00000, 0.00000, 50.00000);
	CreateDynamicObject(1575, 2188.08008, -1254.34998, 1528.09998,   0.00000, 0.00000, 5.00000);
	CreateDynamicObject(1829, 2190.12988, -1256.13000, 1528.57996,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2332, 2189.31006, -1256.43994, 1528.58997,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(355, 2188.70996, -1256.38000, 1528.33997,   10.00000, -90.00000, 90.00000);
	CreateDynamicObject(372, 2189.17993, -1256.38000, 1529.05005,   90.00000, 0.00000, -20.00000);
	CreateDynamicObject(2836, 2190.98999, -1247.78003, 1528.10999,   0.00000, 0.00000, -42.00000);
	CreateDynamicObject(2109, 2198.31006, -1247.66003, 1528.48999,   0.00000, 0.00000, 40.00000);
	CreateDynamicObject(2121, 2199.21997, -1246.65002, 1528.60999,   0.00000, 0.00000, -30.00000);
	CreateDynamicObject(2121, 2199.53003, -1248.43005, 1528.60999,   0.00000, 0.00000, -120.00000);
	CreateDynamicObject(2121, 2197.60010, -1248.81995, 1528.60999,   0.00000, 0.00000, 1230.00000);
	CreateDynamicObject(2121, 2196.78003, -1247.87000, 1528.60999,   0.00000, 0.00000, 94.00000);
	CreateDynamicObject(2121, 2196.97998, -1246.59998, 1528.60999,   0.00000, 0.00000, 50.00000);
	CreateDynamicObject(2103, 2203.93994, -1245.35999, 1529.14001,   0.00000, 0.00000, -86.00000);
	CreateDynamicObject(2829, 2199.75000, -1243.67004, 1529.14001,   0.00000, 0.00000, 80.00000);
	CreateDynamicObject(2830, 2199.62988, -1245.53003, 1529.15002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2831, 2203.71997, -1243.46997, 1529.15002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2254, 2196.15991, -1247.80005, 1530.31006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18665, 2198.41992, -1249.29004, 1529.95996,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2189, 2198.31006, -1247.66003, 1528.93005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1510, 2199.04004, -1247.56006, 1528.93005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1510, 2197.62012, -1248.10999, 1528.93005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1510, 2197.61011, -1247.25000, 1528.93005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1485, 2199.08008, -1247.38000, 1529.02002,   0.00000, 30.00000, -90.00000);
	CreateDynamicObject(3027, 2199.08008, -1247.60999, 1528.97998,   0.00000, 120.00000, 120.00000);
	CreateDynamicObject(3034, 2204.16992, -1247.59998, 1530.12000,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2131, 2203.69995, -1248.80005, 1528.09998,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2627, 2189.22998, -1239.83997, 1528.07996,   0.00000, 0.00000, -120.00000);
	CreateDynamicObject(2628, 2189.42993, -1242.06006, 1528.09998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1985, 2192.42993, -1240.30005, 1531.23999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2202.62988, -1252.78003, 1531.47998,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2202.62988, -1243.15002, 1531.47998,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2192.12988, -1243.15002, 1531.47998,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2192.12988, -1252.78003, 1531.47998,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(1485, 2190.03003, -1251.05005, 1528.69995,   0.00000, 30.00000, 180.00000);
	CreateDynamicObject(1486, 2189.87012, -1250.41003, 1528.75000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1486, 2189.39990, -1250.87000, 1528.75000,   0.00000, 0.00000, 134.00000);
	CreateDynamicObject(1543, 2189.38989, -1250.35999, 1528.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 2189.54004, -1250.21997, 1528.59998,   0.00000, 0.00000, 40.00000);
	CreateDynamicObject(1544, 2189.84009, -1250.79004, 1528.59998,   0.00000, 0.00000, 30.00000);
	CreateDynamicObject(1544, 2189.78003, -1250.18005, 1528.59998,   0.00000, 0.00000, 30.00000);
	CreateDynamicObject(2074, 2189.59009, -1250.62000, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2190.12988, -1244.92004, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2194.66992, -1250.47998, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2200.61011, -1250.47998, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2201.69995, -1244.84998, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2073, 2198.25000, -1247.66003, 1530.68994,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2190.85010, -1240.85999, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2198.12012, -1253.75000, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2074, 2196.36011, -1242.71997, 1531.16003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1498, 2187.41992, -1245.60999, 1528.02002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1498, 2204.23999, -1251.23999, 1528.02002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 2196.02002, -1249.71997, 1528.09998,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19365, 2193.39990, -1248.83997, 1529.87000,   0.00000, 0.00000, 0.00000);
	//Ms13 ws
	CreateDynamicObject(19905, 1103.81360, -1244.35168, 14.93130,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18981, 1102.49023, -1234.91455, 14.35100,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(18981, 1093.97021, -1234.91455, 14.35100,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(18981, 1093.97021, -1241.19458, 14.35100,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(3361, 1084.67163, -1245.51184, 19.05340,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3361, 1084.67163, -1237.29175, 14.99340,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2395, 1084.15515, -1250.91687, 21.18630,   -90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19899, 1118.63318, -1251.23975, 15.13220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19899, 1109.01318, -1251.23975, 15.13220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19899, 1100.15295, -1251.23975, 15.13220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19899, 1090.93323, -1251.23975, 15.13220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19900, 1107.38684, -1251.29260, 15.15610,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19900, 1098.44678, -1251.29260, 15.15610,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19900, 1089.24683, -1251.29260, 15.15610,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19815, 1094.86780, -1251.85803, 17.25630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19815, 1095.53345, -1251.68823, 17.26000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19815, 1104.33337, -1251.68823, 17.26000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19817, 1099.37805, -1241.29700, 13.28060,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19817, 1090.47815, -1241.29700, 13.28060,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19817, 1108.23816, -1241.29700, 13.28060,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19817, 1117.33813, -1241.29700, 13.28060,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19903, 1106.44995, -1251.28760, 15.14810,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1118.83130, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1115.71130, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1109.75134, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1106.63135, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1100.71130, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1097.59131, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1091.63135, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1088.35132, -1235.90112, 15.04440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10281, 1121.00330, -1213.92029, 23.52220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(984, 1106.32959, -1222.44678, 18.06010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(984, 1093.52954, -1222.44678, 18.06010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(984, 1087.20959, -1222.44678, 18.06010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18981, 1110.15015, -1209.53455, 16.63100,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(18981, 1090.71021, -1209.53455, 16.63100,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(984, 1115.92957, -1197.20679, 17.98010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(984, 1103.12964, -1197.20679, 17.98010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(984, 1090.32959, -1197.20679, 17.98010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(984, 1088.70959, -1197.20679, 17.98010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1075, 1086.44934, -1245.02283, 15.62370,   4.00000, -14.00000, 0.00000);
	CreateDynamicObject(1083, 1086.45923, -1243.98865, 15.60060,   0.00000, -18.00000, 0.00000);
	CreateDynamicObject(1084, 1086.29919, -1244.58862, 16.42060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1076, 1095.25171, -1251.43567, 15.57310,   0.00000, -16.00000, 90.00000);
	CreateDynamicObject(1077, 1096.21252, -1251.53564, 15.56170,   0.00000, -23.00000, 91.00000);
	CreateDynamicObject(1078, 1086.44275, -1247.99890, 15.53810,   0.00000, -14.00000, 0.00000);
	CreateDynamicObject(1097, 1086.44287, -1248.96130, 15.52720,   0.00000, -14.00000, 0.00000);
	CreateDynamicObject(1082, 1086.40259, -1248.44556, 16.34690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1085, 1120.94263, -1248.36804, 15.58180,   0.00000, -14.00000, 180.00000);
	CreateDynamicObject(1096, 1120.92236, -1247.33350, 15.54370,   0.00000, -14.00000, 180.00000);
	CreateDynamicObject(1080, 1121.19763, -1247.78088, 16.32380,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1079, 1120.91931, -1239.31335, 15.58230,   0.00000, -14.00000, 180.00000);
	CreateDynamicObject(1073, 1120.91846, -1240.32434, 15.56430,   0.00000, -14.00000, 180.00000);
	CreateDynamicObject(1074, 1121.19873, -1239.84363, 16.34250,   0.00000, 0.00000, 178.00000);
	CreateDynamicObject(1081, 1086.52014, -1239.99890, 15.62210,   0.00000, -14.00000, 0.00000);
	CreateDynamicObject(1025, 1086.46021, -1238.92114, 15.59910,   0.00000, -14.00000, 0.00000);
	CreateDynamicObject(1010, 1091.84229, -1251.69727, 17.43470,   270.00000, 0.00000, 0.00000);
	CreateDynamicObject(1010, 1091.84229, -1251.69727, 16.53470,   270.00000, 0.00000, 0.00000);
	CreateDynamicObject(1010, 1101.04236, -1251.69727, 16.91470,   270.00000, 0.00000, 0.00000);
	CreateDynamicObject(1008, 1119.49304, -1251.07495, 16.83910,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(1008, 1108.81311, -1251.07495, 16.49910,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(2808, 1083.08240, -1229.47668, 15.48010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2808, 1083.08240, -1231.51672, 15.48010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2808, 1083.08240, -1223.65674, 15.48010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2808, 1083.08240, -1233.25671, 15.48010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19245, 1118.28967, -1235.54993, 14.97896,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 1112.49133, -1220.42114, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1112.49133, -1217.32104, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1107.17126, -1217.32104, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1107.17126, -1220.42114, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1102.03125, -1220.42114, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1102.01135, -1217.32104, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1097.15125, -1217.32104, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1097.15125, -1220.42114, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1091.91125, -1220.42114, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1091.91125, -1217.32104, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1087.13135, -1217.32104, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1087.13135, -1220.42114, 17.12440,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2614, 1103.77271, -1236.13464, 19.09360,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2770, 1112.37964, -1223.05872, 15.44460,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(988, 1078.47217, -1208.11523, 16.27760,   0.00000, 0.00000, -91.98000);
	CreateDynamicObject(988, 1078.47217, -1206.45715, 16.27760,   0.00000, 0.00000, -91.98000);

	//CITY HALL ORI
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2665.608398, 2.503499, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2675.227539, 2.502500, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.362670, 2675.227539, 2.502500, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.342773, 2665.609619, 2.502500, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1849.627807, 2670.541503, 2.295900, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.266235, 2670.312011, 2.571599, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.265258, 2670.771972, 2.572598, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.625244, 2670.771972, 2.572598, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.975341, 2670.770996, 2.573600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.975341, 2670.312011, 2.571599, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.606201, 2670.311035, 2.572598, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1849.657470, 2670.547851, 1.015310, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1849.588134, 2665.882568, 3.009900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2826, -1847.271606, 2670.599365, 2.923000, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19325, -1852.875488, 2660.788574, 4.621300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1843.011352, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1842.821411, 2660.781738, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1849.663940, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1849.474853, 2660.782714, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1847.446533, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1845.264648, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1844.044555, 2660.782714, 2.538700, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1846.246093, 2660.783691, 2.538700, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1844.024658, 2660.782714, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1846.246093, 2660.783691, 6.433497, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1845.076538, 2660.783691, 5.877297, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1847.256469, 2660.784667, 5.877297, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1848.446044, 2660.782714, 2.537698, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1848.446044, 2660.782714, 6.433497, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18980, -1841.403808, 2647.870605, 7.060749, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1845.337036, 2651.081787, 7.060749, 90.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1857.907470, 2677.627685, 7.060748, 90.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1857.907470, 2652.658203, 7.060748, 90.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1851.465942, 2689.799072, 7.060748, 90.000000, 0.000000, 450.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19325, -1846.251464, 2660.788574, 4.621300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1850.706665, 2660.782714, 2.537698, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1852.927612, 2660.782714, 2.537698, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1855.088500, 2660.781738, 2.538700, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1856.293334, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1851.854492, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1854.107177, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1850.706665, 2660.782714, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1852.867553, 2660.782714, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1855.088500, 2660.781738, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1851.664916, 2660.782714, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1853.918945, 2660.782714, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1856.104980, 2660.782714, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18980, -1841.415405, 2692.620361, 7.060748, 90.000000, 0.000000, 540.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1845.565673, 2680.030029, 7.060748, 90.000000, 0.000000, 630.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1839.565673, 2672.816162, 7.060749, 90.000000, 0.000000, 720.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1867.287841, 2675.217773, 7.060748, 90.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1879.818359, 2663.007080, 7.060748, 90.000000, 0.000000, 450.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18980, -1879.818359, 2677.928710, 7.060748, 90.000000, 0.000000, 450.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2270, -1857.324096, 2656.822753, 4.285367, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1499, -1856.231567, 2660.800292, 2.590800, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 3899, "hospital2", "dustyconcrete128", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.288452, 2660.781738, 5.041399, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.875244, 2660.781738, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.685058, 2660.782714, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.288452, 2660.781738, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1859.552978, 2660.788574, 7.212100, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19381, -1857.905517, 2662.018310, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1857.901977, 2662.018310, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19325, -1846.251464, 2680.040039, 4.621300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19325, -1852.891967, 2680.040039, 4.621300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1843.011352, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1845.264648, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1847.446533, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1854.107177, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1851.854492, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1856.293334, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.875244, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1842.821411, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1845.076538, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1847.256469, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1849.474853, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1851.664916, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1853.918945, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1856.104980, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.685058, 2680.028564, 5.877298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1849.663940, 2680.028076, 3.668699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1844.044555, 2680.028320, 2.538700, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1846.246093, 2680.028320, 2.538700, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1848.446044, 2680.028320, 2.537698, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1850.706665, 2680.028320, 2.537698, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1852.927612, 2680.028320, 2.537698, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1855.088500, 2680.028320, 2.538700, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1844.024658, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1846.246093, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1848.446044, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1850.696655, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1852.867553, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1855.088500, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.288452, 2680.026855, 5.041399, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1499, -1856.231567, 2680.052001, 2.590800, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 3899, "hospital2", "dustyconcrete128", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1857.901977, 2678.969726, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1857.905517, 2678.969726, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2257, -1857.790893, 2677.120361, 4.500400, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING30", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1859.552978, 2680.040039, 7.212100, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19377, -1838.081176, 2660.809082, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1838.075195, 2660.799072, 1.335399, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1838.075195, 2680.044677, 1.335399, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1838.085205, 2680.024658, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(2271, -1857.319580, 2656.086669, 4.298297, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19381, -1839.435180, 2662.566650, 0.865400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1866.614013, 2670.462646, 6.722198, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19369, -1839.415039, 2670.537109, 4.302740, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "liftdoorsac256", 0xFF666666);
	tmpobjid = CreateDynamicObjectEx(18763, -1849.867797, 2691.156738, 4.688566, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2257, -1849.549804, 2689.644775, 5.206540, 0.000000, 0.000000, 360.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING36", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18763, -1849.317260, 2691.166748, 4.688566, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18763, -1849.867797, 2649.703613, 4.688566, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18763, -1849.307250, 2649.693603, 4.688566, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2670.469482, 6.845121, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1858.917602, 2666.360595, 4.462637, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1863.088500, 2666.360595, 4.462637, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2672.937988, 4.267300, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2668.138427, 4.315120, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2679.169433, 4.267300, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.568115, 2678.119384, -2.605329, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1839.435180, 2678.522216, 0.865400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.568115, 2678.119384, 11.350060, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2679.169433, 7.744729, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2672.937988, 7.762588, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.153808, 2678.854980, 3.748708, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.153808, 2673.255615, 3.731138, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.148437, 2676.153808, 2.151438, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.148437, 2676.153808, 6.580608, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2668.138427, 7.762598, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2661.689208, 4.267300, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.570434, 2661.689208, 7.762598, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.568115, 2663.411376, -2.605298, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.568115, 2663.411376, 11.350098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.153808, 2667.829101, 3.748698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.153808, 2662.002929, 3.748698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.153808, 2664.876708, 2.151400, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.153808, 2664.876708, 6.580598, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.342773, 2657.746093, 6.913798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.362670, 2683.112548, 6.913798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2683.112548, 6.913798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1860.977783, 2666.370605, 6.542635, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19482, -1849.625976, 2671.914306, 2.720704, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "CITY HALL", 130, "Arial", 60, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(19482, -1849.635986, 2671.914306, 2.680704, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "CITY HALL", 130, "Arial", 60, 1, 0xFF000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2657.746093, 6.913798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1858.245239, 2679.792968, 6.695098, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.288452, 2680.026855, 6.433498, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.114257, 2672.625976, 3.748698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.114257, 2668.454345, 3.748698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1839.114379, 2669.826660, 6.540598, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1836.267456, 2667.370361, 6.914800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1836.266479, 2673.507080, 6.912798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1861.582397, 2667.370361, 6.914800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1861.581420, 2673.554443, 6.912798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1865.309326, 2670.494873, 2.502500, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.078369, 2660.567138, 6.695098, 180.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-30-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2655.940429, 2.503499, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.342773, 2655.940429, 2.502500, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1858.619628, 2666.749755, 4.327300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1858.619628, 2674.239257, 4.319610, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1858.619628, 2674.239257, 7.807650, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1858.619628, 2666.749755, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19369, -1860.976562, 2666.598388, 4.312708, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "liftdoorsac256", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1859.350219, 2666.651367, 4.225598, 0.000000, 90.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1859.335815, 2666.047607, 4.307400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1859.175781, 2666.048583, 4.307400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1859.015747, 2666.049560, 4.307400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1859.015747, 2666.049560, 7.805698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1859.175781, 2666.048583, 7.805698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1859.335815, 2666.047607, 7.805698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1863.383178, 2666.749755, 4.327300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1862.646362, 2666.631347, 4.225598, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1862.668823, 2666.047607, 4.307400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1862.845947, 2666.047607, 4.307400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1863.016845, 2666.046630, 4.307400, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1862.668823, 2666.047607, 7.805698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1862.845947, 2666.047607, 7.805698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1863.016845, 2666.046630, 7.805698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1861.646362, 2666.651367, 6.116899, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1860.218750, 2666.759765, 7.795700, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1861.787719, 2666.758789, 7.795700, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1860.201782, 2674.239257, 4.319600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1861.785156, 2674.239257, 4.319600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1863.389038, 2674.239257, 4.319600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1864.972045, 2674.239257, 4.319600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1860.201782, 2674.239257, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1861.785156, 2674.239257, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1863.389038, 2674.239257, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1864.972045, 2674.239257, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1863.383178, 2666.749755, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1864.978515, 2666.749755, 4.327300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1866.582031, 2666.749755, 4.327300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2257, -1865.205932, 2666.863525, 4.500400, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING36", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1864.978515, 2666.749755, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1866.582031, 2666.749755, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1866.562011, 2674.239257, 4.327300, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1866.562011, 2674.239257, 7.807600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.956909, 2666.964355, 3.668699, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1857.938964, 2667.001708, 4.621300, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.955932, 2666.775878, 5.463140, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.933837, 2667.988525, 2.538700, 90.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.933837, 2672.968505, 2.538700, 90.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1857.938964, 2673.919921, 4.621300, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.956909, 2669.198486, 3.668699, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.955932, 2669.009033, 5.877298, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.933837, 2667.988525, 6.444320, 90.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.956909, 2671.926513, 3.668699, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.955932, 2671.737792, 5.877298, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.956909, 2674.220458, 3.668699, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.956909, 2674.220458, 5.899700, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1857.933837, 2672.988525, 6.461200, 90.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1858.017944, 2670.820556, 6.695098, 180.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19434, -1858.618774, 2666.751220, 1.433699, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1863.875854, 2666.751220, 1.433699, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1865.462768, 2666.751220, 1.433699, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1866.595458, 2666.752197, 1.433699, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1867.344116, 2678.969726, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1867.363647, 2662.018310, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1862.632812, 2674.234375, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1872.607910, 2675.299560, 2.504498, 0.000000, 90.000000, 0.059999, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1872.607910, 2665.709960, 2.503499, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1874.020874, 2670.447753, 3.041198, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1874.020874, 2665.483642, 3.041178, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1874.020874, 2675.426025, 3.041198, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2665.232910, 2.531599, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2669.849365, 2.531599, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2674.451416, 2.531599, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.627441, 2675.673095, 2.532598, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2663.793212, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2665.388671, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2666.982421, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2668.581787, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2670.183349, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2671.782714, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2673.382568, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.609497, 2674.973388, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.608520, 2676.559814, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19434, -1873.607543, 2677.121093, 1.154098, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1872.607910, 2675.299560, 6.914800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1872.607910, 2665.709960, 6.914800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1874.020874, 2665.483642, 6.329198, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1874.020874, 2670.447753, 6.329198, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1874.020874, 2675.426025, 6.329198, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2665.232910, 6.881700, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2669.849365, 6.881700, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2674.451416, 6.881700, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.628417, 2675.673095, 6.882699, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1874.027465, 2670.661376, 7.640600, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19381, -1874.026245, 2667.919433, 11.037300, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1874.027221, 2672.979980, 11.036298, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1874.024658, 2663.899414, 4.327300, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1874.024658, 2677.009521, 4.327300, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1874.026245, 2667.919433, -1.651298, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1874.027221, 2672.979980, -1.652300, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19325, -1874.027465, 2666.542968, 7.640600, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19325, -1874.027465, 2674.784423, 7.640600, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.748413, 2665.292968, 5.904600, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.748413, 2669.903320, 5.904600, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.748413, 2674.507812, 5.904600, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1873.748413, 2675.588867, 5.903600, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2663.673828, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2677.198730, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2670.631591, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2669.050292, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2672.192138, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2665.117919, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2675.768554, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2674.287597, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1873.641967, 2666.603515, 6.515298, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1897, -1874.036987, 2668.713378, 4.668000, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1897, -1874.036987, 2672.813720, 4.668000, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1714, -1875.740234, 2674.564453, 2.570600, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1714, -1875.740234, 2670.688720, 2.570600, 0.000000, 0.000000, 78.059967, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1714, -1875.740234, 2666.476806, 2.570600, 0.000000, 0.000000, 93.239990, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1841.430419, 2673.481201, 12.078200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1841.431396, 2667.350341, 12.078200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1851.577392, 2678.380859, 12.078200, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1841.958251, 2678.380859, 12.078200, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1851.577392, 2662.475097, 12.078200, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1841.958251, 2662.475097, 12.078200, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1856.419677, 2667.350341, 12.078200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1856.417724, 2673.481201, 12.078200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1851.179931, 2681.094726, 7.455298, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1840.688720, 2681.094726, 7.455298, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.096557, 2671.040283, 7.455298, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.097534, 2667.715332, 7.456298, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1859.125976, 2671.040283, 7.455298, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1859.125976, 2667.715332, 7.458300, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1840.688720, 2660.179199, 7.455298, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1851.179931, 2660.177246, 7.456298, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1843.826171, 2671.575439, 12.619198, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1843.828247, 2669.780761, 12.619198, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1848.715209, 2664.909423, 12.619198, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1849.813598, 2664.908447, 12.620200, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1849.813598, 2676.351074, 12.619198, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1848.716186, 2676.352050, 12.617198, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1854.392456, 2669.780761, 12.620200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1854.393554, 2671.574462, 12.618200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1844.373291, 2667.447998, 7.984000, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1844.373291, 2672.434082, 7.984000, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1844.373291, 2677.406494, 7.984000, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1847.366333, 2675.783691, 7.984000, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1852.362670, 2675.783691, 7.984000, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1853.816894, 2677.406494, 7.986000, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18762, -1853.816894, 2672.434082, 7.984000, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1853.816894, 2667.447998, 7.984000, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1847.366333, 2665.482666, 7.984000, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1852.362670, 2665.482666, 7.985000, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1857.901977, 2652.413330, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1857.905517, 2652.389404, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1853.016235, 2651.089843, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1843.381591, 2651.089843, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1853.065429, 2651.082519, 1.335399, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1843.445800, 2651.082519, 1.335399, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1841.430908, 2655.918701, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1841.427490, 2655.919921, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1838.081176, 2660.792968, -2.066498, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2648.133056, 6.913798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.342773, 2648.133056, 6.913798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.619628, 2650.640136, 6.695098, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-30-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2934, -1852.397949, 2666.904296, 8.968400, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1852.397949, 2674.046875, 8.968400, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1847.318725, 2673.743896, 8.969400, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1847.318725, 2670.632568, 8.966400, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1847.318725, 2667.523437, 8.967398, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2666.121093, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2664.719726, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2663.258300, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2661.836914, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2660.434814, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2659.051269, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2657.648925, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2656.207275, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2654.823486, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2653.418457, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2651.994628, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2604, -1842.047729, 2656.076416, 3.344799, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2610, -1842.212158, 2653.931396, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2610, -1842.212158, 2653.398925, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2610, -1842.212158, 2652.851806, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2162, -1841.558959, 2660.188964, 2.587698, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2241, -1842.217773, 2653.413330, 4.726200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2251, -1842.026000, 2659.061279, 4.357318, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1714, -1843.164062, 2654.807617, 2.568700, 0.000000, 0.000000, 143.940078, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1843.703491, 2658.084716, 2.601300, 0.000000, 0.000000, -170.039932, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1842.775756, 2656.866943, 2.601300, 0.000000, 0.000000, -99.239967, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19482, -1849.625976, 2672.184570, 2.170703, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "L O S  S A N T O S", 130, "Arial", 30, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(1827, -1846.938232, 2652.422851, 2.516299, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19462, -1849.454589, 2656.084472, 2.529900, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_wuziMirror", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1848.143188, 2656.325195, 1.153900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1848.142211, 2655.825195, 1.152899, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1850.742187, 2655.824218, 1.153900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1850.743041, 2656.325195, 1.152899, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2166, -1846.805297, 2655.503906, 2.616498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1714, -1845.531738, 2655.052490, 2.608700, 0.000000, 0.000000, 215.159896, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1848.241455, 2657.095947, 2.601300, 0.000000, 0.000000, -99.239967, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1848.215942, 2655.462402, 2.601300, 0.000000, 0.000000, -81.719993, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1857.640747, 2656.925537, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1857.640747, 2656.204833, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1857.640747, 2655.504150, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1302, -1857.496582, 2653.477539, 2.589298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2161, -1852.967651, 2651.174560, 2.589400, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2161, -1854.429931, 2651.174560, 2.589400, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2934, -1849.955688, 2649.621093, 4.349598, 90.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1849.221923, 2649.621093, 4.349598, 90.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2252, -1846.728881, 2652.372314, 3.259500, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2826, -1847.308837, 2652.476806, 2.943000, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2257, -1849.549804, 2651.215576, 5.206540, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING36", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1855.630493, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.072509, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1854.220092, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1852.833007, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1851.447753, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1847.021972, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1845.583496, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1844.139160, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1842.678833, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.296020, 2651.048828, 6.336200, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.399658, 2651.938720, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.399658, 2653.351318, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.399658, 2654.796142, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.399658, 2656.220214, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.398681, 2657.642333, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.399658, 2658.625732, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.399658, 2660.020996, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2934, -1847.431152, 2663.460205, 8.832400, 180.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1854.580688, 2663.460205, 8.832400, 180.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1842.370483, 2668.499511, 8.832400, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1842.370483, 2675.646484, 8.832400, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1847.483398, 2677.808349, 8.832400, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1854.639648, 2677.808349, 8.832400, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1855.851562, 2672.831054, 8.832400, 180.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1855.851562, 2665.710937, 8.832400, 180.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2684.894531, 2.502500, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.362670, 2684.894531, 2.501498, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1857.901977, 2688.590087, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1857.905517, 2688.591308, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1853.030639, 2689.776855, -2.067500, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1843.401000, 2689.776855, -2.067500, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1841.430908, 2684.897216, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1841.427490, 2684.908935, 1.335399, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1853.026367, 2689.782470, 1.335399, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1843.406616, 2689.782470, 1.335399, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1844.362670, 2692.720703, 6.912798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1854.840454, 2692.720703, 6.915800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2257, -1857.790893, 2663.791748, 4.500400, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING35", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2252, -1853.131469, 2651.506347, 4.258900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19893, -1846.142089, 2656.341552, 3.406399, 0.000000, 0.000000, 17.339939, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1210, -1845.557739, 2656.586669, 3.506900, 90.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2827, -1846.677001, 2652.717529, 2.942800, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19792, -1846.474975, 2656.292480, 3.425600, 0.000000, 0.000000, 38.759998, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.626831, 2680.586669, 6.693099, 180.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19377, -1838.077148, 2680.054687, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(2960, -1855.570190, 2684.836425, 6.887498, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1843.611450, 2684.836425, 6.887498, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.429809, 2684.836425, 6.867498, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1855.019775, 2680.948730, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1850.032958, 2680.948730, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1845.046264, 2680.948730, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1840.053222, 2680.948730, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1842.401977, 2683.938232, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1842.401977, 2688.936523, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1856.968017, 2683.938232, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1856.968017, 2688.918945, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1855.019775, 2688.835937, 7.297800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1850.042358, 2688.835937, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1845.046752, 2688.835937, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1842.618896, 2688.651855, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1842.813354, 2690.421386, 7.297800, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1856.708129, 2688.651855, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1856.490722, 2690.421386, 7.296800, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1856.708129, 2681.221191, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1858.500488, 2681.387939, 7.296800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1842.618896, 2681.221191, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1840.843994, 2681.393798, 7.296800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1849.414306, 2684.864501, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1849.397705, 2685.023437, 6.722198, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19482, -1849.645996, 2672.184570, 2.140703, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "L O S  S A N T O S", 130, "Arial", 30, 1, 0xFF000000, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(2934, -1849.221923, 2691.245605, 4.349598, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1849.962036, 2691.245605, 4.349598, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2674.908935, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2676.318359, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2677.745849, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2679.214843, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2680.878662, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2682.307373, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2683.734375, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2685.199951, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2686.678222, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2688.110839, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.932128, 2689.520996, 6.336200, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1857.083129, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1855.625488, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1854.195922, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1852.737548, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1851.295043, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1847.855957, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1846.456909, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1844.977661, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1843.519653, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1842.108032, 2689.817626, 6.336200, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2689.500976, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2688.110839, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2686.678222, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2685.199951, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2683.734375, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2682.307373, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1841.407714, 2680.878662, 6.336200, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1726, -1850.598632, 2689.127929, 2.541100, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.010800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1848.294921, 2670.431884, 10.004798, 0.000000, 90.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.008798, 0.000000, 90.000000, 10.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.007800, 0.000000, 90.000000, 30.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.098798, 0.000000, 90.000000, 50.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.002799, 0.000000, 90.000000, 70.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.003800, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.590698, 2657.678466, -2.066498, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1839.580688, 2683.179199, -2.066498, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.097800, 0.000000, 90.000000, -50.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 9.992798, 0.000000, 90.000000, -30.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.011798, 0.000000, 90.000000, -10.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.097998, 0.000000, 90.000000, -130.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.009799, 0.000000, 90.000000, -150.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.006798, 0.000000, 90.000000, -170.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.009799, 0.000000, 90.000000, -190.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.610473, 2672.947998, 1.417299, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 9.992798, 0.000000, 90.000000, 150.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 9.999798, 0.000000, 90.000000, 130.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.002799, 0.000000, 90.000000, -110.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.005800, 0.000000, 90.000000, -70.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.003800, 0.000000, 90.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19692, -1849.974853, 2670.431884, 10.000800, 0.000000, 90.000000, 110.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1727, -1848.444458, 2672.820312, 2.595299, 0.000000, 0.000000, 50.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1727, -1847.727539, 2667.724365, 2.595299, 0.000000, 0.000000, 140.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16093, "a51_ext", "Tar_1line256HV", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1726, -1848.606689, 2651.796630, 2.587698, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19462, -1849.454589, 2684.981689, 2.529900, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_wuziMirror", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19462, -1870.357177, 2670.413085, 2.529900, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_wuziMirror", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2610, -1841.723022, 2686.000000, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2610, -1841.723022, 2686.520751, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2610, -1841.723022, 2687.056640, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2610, -1841.723022, 2687.592041, 3.385200, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1844.226684, 2679.660156, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1846.874755, 2679.660156, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1849.553100, 2679.660156, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1852.215820, 2679.660156, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1854.879516, 2679.660156, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1726, -1847.252197, 2678.729736, 2.587698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1726, -1853.887329, 2678.729736, 2.587698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(638, -1844.226684, 2661.144531, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1846.874755, 2661.144531, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1849.553100, 2661.144531, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1852.215820, 2661.144531, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1854.879516, 2661.144531, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1726, -1845.238159, 2662.063720, 2.587698, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1726, -1851.869750, 2662.063720, 2.587698, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18766, -1849.498046, 2670.453613, 2.118000, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_wuziMirror", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18766, -1849.177978, 2670.453613, 2.117000, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14534, "ab_wooziea", "ab_wuziMirror", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2934, -1848.197631, 2668.976318, 1.153900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1848.197631, 2671.920410, 1.152899, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1850.499755, 2671.920410, 1.151900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1850.499755, 2668.976318, 1.155900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1827, -1847.556640, 2670.530517, 2.496299, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2257, -1862.652221, 2674.135253, 4.601900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2266, "picture_frame", "CJ_PAINTING37", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(638, -1858.436523, 2673.136230, 2.949898, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1858.436523, 2667.781005, 2.949898, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2173, -1843.339355, 2689.058837, 2.587528, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1714, -1842.217041, 2688.152099, 2.568900, 0.000000, 0.000000, -124.860000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9919, "grnwht_sfe", "whitgrn_sfe6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2166, -1846.513183, 2684.515869, 2.616148, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2186, -1846.236572, 2689.192871, 2.588860, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2190, -1841.587158, 2684.422363, 4.106928, 0.000000, 0.000000, -104.520011, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2190, -1841.549194, 2682.159912, 4.425030, 0.000000, 0.000000, -98.339996, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2190, -1841.541625, 2680.895996, 4.425030, 0.000000, 0.000000, -98.339996, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2191, -1852.803100, 2689.176269, 2.588900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2191, -1854.241821, 2689.176269, 2.588900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2191, -1855.677856, 2689.176269, 2.588900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2198, -1857.195434, 2687.061035, 2.587800, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1714, -1855.921997, 2687.984619, 2.568900, 0.000000, 0.000000, -72.899978, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9919, "grnwht_sfe", "whitgrn_sfe6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 9919, "grnwht_sfe", "whitgrn_sfe6", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2270, -1857.324096, 2683.565429, 4.285368, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2271, -1857.319580, 2684.328857, 4.298298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1302, -1857.522827, 2685.821533, 2.589298, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1722, -1857.640747, 2684.158203, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1857.640747, 2683.462646, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1857.640747, 2682.753662, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1722, -1848.007324, 2685.455566, 2.601300, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 10370, "alleys_sfs", "ws_alley_conc3", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(638, -1854.879516, 2680.458007, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1852.215820, 2680.458007, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1849.553100, 2680.458007, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1846.874755, 2680.458007, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1844.226684, 2680.458007, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1726, -1851.865112, 2681.396240, 2.587698, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1726, -1845.237426, 2681.396240, 2.587698, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2234, -1850.115478, 2680.882568, 2.496798, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18889, "forcefields", "glass1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1850.743041, 2684.725097, 1.152899, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1850.743041, 2685.225097, 1.151900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1848.141479, 2685.225097, 1.152899, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1848.141479, 2684.725097, 1.150900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2234, -1855.563598, 2678.353271, 2.496798, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18889, "forcefields", "glass1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2234, -1855.563598, 2661.430419, 2.496798, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18889, "forcefields", "glass1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2855, -1855.022216, 2678.879638, 3.010169, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1849.588134, 2675.019287, 3.009900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(14793, -1861.744628, 2670.462646, 6.722198, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1870.086791, 2669.078613, 1.155900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1870.626831, 2669.078613, 1.155900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1870.626831, 2671.702880, 1.154899, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2934, -1870.086791, 2671.702880, 1.152899, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1867.367797, 2678.966796, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1867.367797, 2662.020996, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1871.897583, 2663.042968, 1.631340, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1871.897583, 2677.880615, 1.610000, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1872.263061, 2677.872070, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1872.086669, 2663.053222, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1883.086791, 2675.299560, 2.504498, 0.000000, 90.000000, 0.059999, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1883.086791, 2665.709960, 2.504498, 0.000000, 90.000000, 0.059999, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1881.502929, 2677.880615, 1.610000, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1881.512939, 2663.042968, 1.610000, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1881.894897, 2677.872070, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1881.694946, 2663.053222, -2.066498, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1881.124877, 2667.798828, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19377, -1881.124877, 2677.420166, -2.066498, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(19381, -1881.142700, 2667.806884, 1.610000, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19381, -1881.142700, 2677.420654, 1.610000, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3292, "cxrf_payspray", "sf_spray1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19462, -1881.127929, 2670.501708, 4.969698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1883.086791, 2675.299560, 6.914000, 0.000000, 90.000000, 0.059999, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19377, -1883.086791, 2665.709960, 6.914000, 0.000000, 90.000000, 0.059999, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1877.970825, 2670.657470, 6.732200, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2162, -1881.036010, 2675.867919, 2.590698, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2164, -1880.989990, 2664.058593, 2.591000, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2140, -1877.360107, 2663.664062, 2.588000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2140, -1878.346313, 2663.664062, 2.588000, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2140, -1880.504150, 2670.477294, 2.568690, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2140, -1880.504150, 2669.504638, 1.847900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2140, -1880.504150, 2671.453125, 1.847900, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 14479, "skuzzy_motelmain", "mp_CJ_Laminate1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2199, -1878.023315, 2677.630859, 2.591000, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2197, -1876.736328, 2676.692138, 2.590500, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2197, -1876.044311, 2676.692138, 2.590500, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2165, -1880.515258, 2666.761230, 2.590800, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2165, -1880.393310, 2673.119628, 2.590800, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2197, -1876.474121, 2664.543701, 2.590500, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2197, -1875.738525, 2664.537109, 2.590500, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1721, -1879.652709, 2663.603271, 2.591150, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1721, -1879.604248, 2666.996337, 2.591150, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1721, -1879.525146, 2674.112548, 2.591200, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 3881, "apsecurity_sfxrf", "ws_rooftarmac2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2011, -1875.093017, 2677.125732, 2.591550, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(2257, -1870.503540, 2677.783935, 4.601900, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2254, "picture_frame_clip", "CJ_PAINTING27", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2257, -1870.353271, 2663.138671, 4.601900, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2254, "picture_frame_clip", "CJ_PAINTING26", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(638, -1854.877441, 2660.323486, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1852.215820, 2660.323486, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1849.553100, 2660.323486, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1846.874755, 2660.323486, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(638, -1844.226684, 2660.323486, 2.949898, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "dustyconcrete128", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1726, -1853.863281, 2659.409667, 2.587698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1726, -1847.261840, 2659.409667, 2.587698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1560, "7_11_door", "CJ_CHROME2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10778, "airportcpark_sfse", "ws_fluorescent2", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2234, -1850.022460, 2658.975341, 2.496798, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18889, "forcefields", "glass1", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19893, -1846.046508, 2685.358642, 3.406270, 0.000000, 0.000000, 30.839990, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19835, -1845.183593, 2685.367919, 3.486299, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19893, -1874.331542, 2674.651367, 3.550040, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19893, -1874.265747, 2670.823486, 3.549998, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19893, -1874.267333, 2666.422119, 3.549998, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-95-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1842.401977, 2652.993652, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18762, -1842.401977, 2657.968261, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(18762, -1845.387939, 2652.062988, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1850.377075, 2652.062988, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1855.364257, 2652.062988, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1856.998413, 2657.968261, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1856.998413, 2652.993652, 7.297800, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1855.364257, 2659.904541, 7.297800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1850.377075, 2659.904541, 7.298799, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1845.387939, 2659.904541, 7.299798, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1855.570190, 2655.879394, 6.887498, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1843.611450, 2655.879394, 6.887498, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1849.414306, 2655.879394, 7.298799, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(2960, -1849.429809, 2655.879394, 6.867498, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1842.572998, 2659.719970, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1840.762451, 2659.505859, 7.296800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1856.734008, 2659.719970, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1858.546752, 2659.505859, 7.296800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1856.734008, 2652.276367, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1858.546752, 2652.421386, 7.296800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(964, -1842.572998, 2652.276367, 7.744200, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "grey-20-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "grey-20-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18762, -1840.762451, 2652.426269, 7.296800, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(1656, -1858.733520, 2666.715087, 6.577798, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(19482, -1873.506591, 2668.134277, 2.110703, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "1", 130, "Arial", 50, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(19482, -1873.506591, 2678.125000, 2.110703, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "3", 130, "Arial", 50, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(1656, -1862.976074, 2666.715087, 6.577798, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1864.443969, 2666.725097, 6.577798, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1865.915405, 2666.725097, 6.577798, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1866.343872, 2674.273437, 6.577798, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1858.737548, 2674.273437, 6.577798, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1860.169921, 2674.273437, 6.577798, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1861.606445, 2674.273437, 6.577798, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1863.068847, 2674.273437, 6.577798, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1864.604858, 2674.273437, 6.577798, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1867.317993, 2674.878906, 6.320098, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1867.317993, 2676.268066, 6.320098, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1867.317993, 2677.725830, 6.320098, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1868.332031, 2677.895751, 6.320098, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1869.818115, 2677.895751, 6.320098, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1871.297729, 2677.895751, 6.320098, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1872.768554, 2677.895751, 6.320098, 90.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1868.132446, 2663.011474, 6.320098, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1869.602905, 2663.011474, 6.320098, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1871.026123, 2663.011474, 6.320098, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1872.491333, 2663.011474, 6.320098, 90.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1867.329589, 2666.101562, 6.320098, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1867.329589, 2664.631591, 6.320098, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(1656, -1867.329589, 2663.171875, 6.320098, 90.000000, 0.000000, -90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-95-percent", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObjectEx(14793, -1849.277587, 2681.653564, 7.282199, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1849.277587, 2659.521484, 7.282199, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1839.297241, 2670.521240, 7.282199, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1859.637695, 2670.521240, 7.282199, 0.000000, 0.000000, 180.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(19482, -1873.506591, 2673.255371, 2.110703, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "2", 130, "Arial", 50, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObjectEx(19433, -1839.610473, 2668.136962, 1.417299, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 14629, "ab_chande", "ab_goldpipe", 0xFF333333);
	tmpobjid = CreateDynamicObjectEx(14793, -1849.577880, 2657.552246, 6.732200, 0.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1835.818359, 2675.024658, 6.732203, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(14793, -1835.818359, 2665.983154, 6.732203, 0.000000, 0.000000, 270.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObjectEx(18980, -1845.533935, 2660.839355, 7.060749, 90.000000, 0.000000, 90.000000, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-20-percent", 0xFFFFFFFF);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObjectEx(2252, -1847.729248, 2670.595458, 3.259500, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1656, -1839.452148, 2671.598632, 6.660230, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1656, -1839.451049, 2670.943847, 6.660200, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1656, -1839.452148, 2669.598632, 6.660200, 180.000000, 0.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1656, -1840.735595, 2680.292968, 6.695098, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1656, -1839.390625, 2680.292968, 6.695098, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2965, -1873.497314, 2670.579345, 3.256299, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2965, -1873.497314, 2665.461669, 3.256299, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2965, -1873.497314, 2675.444824, 3.256299, 0.000000, 90.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(19380, -1849.273193, 2670.634521, 7.611800, 0.000000, 90.000000, 90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1656, -1840.864135, 2651.380615, 6.695098, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2011, -1842.101928, 2651.827392, 2.568099, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(626, -1856.770507, 2651.712890, 4.628499, 0.000000, 0.000000, 328.860198, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(19835, -1845.414672, 2656.181152, 3.500128, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1316, -1849.958374, 2670.456054, 7.451360, 180.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2164, -1841.588867, 2681.465576, 2.586998, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2164, -1841.588867, 2683.314208, 2.586998, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2167, -1841.588867, 2684.299804, 2.587599, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2167, -1841.588867, 2685.220458, 2.587599, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(626, -1849.427978, 2678.746826, 4.628499, 0.000000, 0.000000, 328.860198, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(626, -1842.771850, 2678.746826, 4.628499, 0.000000, 0.000000, 328.860198, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(626, -1842.771850, 2661.884277, 4.628499, 0.000000, 0.000000, 328.860198, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(626, -1849.427978, 2661.884277, 4.628499, 0.000000, 0.000000, 328.860198, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1726, -1863.670166, 2673.438964, 2.587698, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2855, -1848.996093, 2681.515625, 3.010730, 0.000000, 0.000000, 178.860183, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2855, -1850.197265, 2681.536376, 3.010730, 0.000000, 0.000000, 178.860183, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2253, -1849.586914, 2681.410400, 3.259598, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2826, -1855.077392, 2661.958496, 3.003000, 0.000000, 0.000000, 86.400016, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2241, -1880.700561, 2671.571289, 5.098330, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2241, -1880.689331, 2669.532226, 5.098330, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2245, -1880.636840, 2670.481933, 5.631168, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1302, -1867.691894, 2664.840576, 2.589298, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(1302, -1867.705932, 2676.008300, 2.589298, 0.000000, 0.000000, -90.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2253, -1874.332885, 2668.635742, 3.819499, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(2253, -1874.332885, 2672.729003, 3.819499, 0.000000, 0.000000, 0.000000, 300.00, 300.00);
	tmpobjid = CreateDynamicObjectEx(626, -1865.503540, 2673.156738, 4.628499, 0.000000, 0.000000, 328.860198, 300.00, 300.00);

    //Burger
	tmpobjid = CreateDynamicObject(970, 1256.964721, -1420.007080, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1256.928588, -1424.177490, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19084, "laserpointer6", "laserbeam-6-64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1256.892211, -1428.347167, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1256.855712, -1432.517578, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19084, "laserpointer6", "laserbeam-6-64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1256.783691, -1440.788452, 13.112154, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19084, "laserpointer6", "laserbeam-6-64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1256.819458, -1436.647705, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1236.225097, -1419.826782, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1236.198120, -1423.997192, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19084, "laserpointer6", "laserbeam-6-64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1236.172607, -1428.166137, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1236.073486, -1440.627685, 13.112154, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19084, "laserpointer6", "laserbeam-6-64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1236.136352, -1432.336181, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19084, "laserpointer6", "laserbeam-6-64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1236.099731, -1436.467285, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(984, 1242.885620, -1442.990966, 13.212260, 0.000000, 0.000000, 90.200042, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(984, 1250.855224, -1442.963256, 13.212260, 0.000000, 0.000000, 90.200042, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19376, 1211.336669, -1420.700439, 12.422868, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19376, 1228.467895, -1420.700439, 12.422868, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19376, 1211.336669, -1430.310424, 12.422868, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19376, 1228.467895, -1430.260253, 12.472869, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19462, 1221.454589, -1420.711303, 12.438803, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19462, 1217.975097, -1420.711303, 12.438803, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19462, 1221.454589, -1430.331176, 12.438803, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(19462, 1217.974853, -1430.331176, 12.438803, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor2", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1219.758422, -1416.375122, 12.848712, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1219.758422, -1416.375122, 18.038726, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1209.312744, -1416.379882, 15.790727, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1230.493774, -1416.379882, 15.790727, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1219.953247, -1416.379882, 15.790727, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1206.603027, -1421.670043, 14.986812, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1206.603027, -1421.670043, 19.906806, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1206.603027, -1425.670410, 14.986812, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 1206.603027, -1425.670410, 19.896812, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(19370, 1206.206054, -1423.689453, 16.678979, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "redlaser", 0x00000000);
	tmpobjid = CreateDynamicObject(19370, 1206.206054, -1423.689453, 20.178983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 1206.190185, -1419.446044, 15.537587, -90.199981, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 1206.190185, -1427.825805, 15.566835, -90.199981, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1219.758422, -1417.324096, 19.028718, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1220.299194, -1428.374511, 19.038719, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1231.404296, -1422.761596, 18.976421, -1.200001, 90.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1219.890502, -1422.701293, 19.035318, -1.200001, 90.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1208.317626, -1422.640625, 19.062936, -1.200001, 90.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 1219.949340, -1422.476196, 19.049295, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "tiles7-128x128", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1233.633300, -1422.948364, 12.508807, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1233.633300, -1424.778198, 12.508807, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1233.203247, -1430.849243, 18.064434, -0.300002, 90.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1232.103515, -1420.736938, 12.508807, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1232.103515, -1430.336669, 12.508807, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1231.939697, -1428.744262, 18.198114, -1.200001, 90.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 19775, "matcopstuff", "copholster1", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1227.251220, -1428.933837, 13.328808, 0.000000, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "adeta", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1217.620971, -1428.933837, 13.328808, 0.000000, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "adeta", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1210.940795, -1428.933837, 13.328808, 0.000000, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "adeta", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1214.641113, -1416.444335, 18.598808, 0.000000, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "policeshieldgls", 0x00000000);
	tmpobjid = CreateDynamicObject(19379, 1225.250854, -1416.444335, 18.598808, 0.000000, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "policeshieldgls", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1201.099243, -1417.939331, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1201.062744, -1422.139282, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1201.026000, -1426.299682, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(970, 1200.989746, -1430.500000, 13.102157, 0.000000, 0.000000, 89.499969, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18643, "laserpointer1", "laserbeam64x64", 0x00000000);
	tmpobjid = CreateDynamicObject(18980, 1208.117553, -1422.640258, 19.038755, -1.200001, 90.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "skullygrn", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1231.540039, -1425.854492, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1230.610229, -1425.833251, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1229.710571, -1425.812988, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1228.791259, -1425.792602, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1227.861450, -1425.771484, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1226.932006, -1425.750854, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1226.001953, -1425.729370, 12.558807, 0.000000, 0.000000, 178.699981, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2454, 1225.080810, -1425.693969, 12.554740, 0.000000, 0.000000, 177.399993, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(2455, 1224.905639, -1426.751586, 12.574744, 0.000000, 0.000000, -88.700012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 1259, "billbrd", "fence1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 3922, "bistro", "Marble2", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	tmpobjid = CreateDynamicObject(18070, 1228.281860, -1427.933715, 16.284740, -180.000000, 0.000000, -0.799996, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 3922, "bistro", "marblekb_256128", 0x00000000);
	tmpobjid = CreateDynamicObject(19482, 1224.820434, -1427.113891, 16.224744, 0.000000, 0.000000, 178.899993, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{000000} Employee Only", 90, "Quartz MS", 25, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(1523, 1224.915893, -1427.192138, 11.094738, 0.000000, 0.000000, -91.300010, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "zorromask", 0x00000000);
	tmpobjid = CreateDynamicObject(1502, 1206.229980, -1425.182373, 12.508806, 0.000000, 0.000000, 90.300003, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
	tmpobjid = CreateDynamicObject(1502, 1206.194946, -1422.162597, 12.508806, 0.000000, 0.000000, -90.999977, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1229.617431, -1418.419555, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1226.157470, -1418.419555, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1222.817382, -1418.419555, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1219.167236, -1418.419555, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1215.196777, -1418.419555, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1210.847167, -1418.419555, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1208.537109, -1420.449707, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1212.576904, -1421.329345, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1217.217163, -1421.329345, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1221.037841, -1421.329345, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1224.477905, -1421.329345, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1594, 1227.858032, -1421.329345, 12.974742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(11691, 1218.885742, -1427.257934, 12.508806, 0.000000, 0.000000, 90.200012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1220.804565, -1427.972167, 13.124740, 0.000000, 0.000000, -91.100006, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1220.834350, -1426.422729, 13.124740, 0.000000, 0.000000, -91.100006, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1216.994995, -1426.344970, 13.124740, 0.000000, 0.000000, 89.799972, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1216.989624, -1427.894531, 13.124740, 0.000000, 0.000000, 89.799972, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1215.495117, -1426.320068, 13.124740, 0.000000, 0.000000, -91.100006, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1215.465087, -1427.869873, 13.124740, 0.000000, 0.000000, -91.100006, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(11691, 1213.545043, -1427.136352, 12.508806, 0.000000, 0.000000, 90.200012, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 16640, "a51", "concreteyellow256 copy", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1211.524536, -1426.325561, 13.124740, 0.000000, 0.000000, 89.799972, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	tmpobjid = CreateDynamicObject(2748, 1211.518798, -1427.865600, 13.124740, 0.000000, 0.000000, 89.799972, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 1, 3786, "missiles_sfs", "ws_greyfoam", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(19383, 1252.445800, -1441.043823, 10.911280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1256.026489, -1441.043823, 10.911280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1248.805541, -1441.043823, 10.911280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1245.435180, -1441.043823, 10.911280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1242.165161, -1441.043823, 10.911280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1238.835693, -1441.043823, 10.911280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1237.984619, -1434.339965, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1237.938232, -1431.040161, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1237.890258, -1427.630249, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1237.840576, -1424.049926, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1237.792480, -1420.569946, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1255.081420, -1420.328979, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1255.129028, -1423.758789, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1255.180664, -1427.498901, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1255.232055, -1431.157958, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19383, 1255.286010, -1435.027587, 10.993985, 0.000000, 0.000000, -89.199958, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1206.109619, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1208.669433, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1211.369628, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1214.269775, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1217.239746, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1221.130249, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1224.239868, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1228.079711, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1229.949707, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1232.759887, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1235.780273, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19121, 1257.390258, -1411.383422, 12.862271, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2431, 1231.491333, -1425.691162, 15.778807, 0.000000, 0.000000, 179.400085, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2416, 1231.551391, -1428.203735, 12.508806, 0.000000, 0.000000, 179.700012, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2416, 1229.671386, -1428.194091, 12.508806, 0.000000, 0.000000, 179.700012, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2429, 1232.255249, -1427.601440, 13.504743, 0.000000, 0.000000, -88.999916, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2429, 1232.255249, -1427.021240, 13.504743, 0.000000, 0.000000, -88.999916, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2425, 1231.930053, -1425.676391, 13.588810, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2425, 1231.389648, -1425.676391, 13.588810, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2422, 1229.638427, -1426.001953, 13.544743, 0.000000, 0.000000, -179.899993, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2422, 1227.688232, -1426.005004, 13.544743, 0.000000, 0.000000, -179.899993, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2422, 1225.547363, -1426.008544, 13.544743, 0.000000, 0.000000, -179.899993, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2643, 1206.044067, -1423.587646, 16.818811, 0.000000, 0.000000, -89.100006, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2642, 1228.783569, -1425.269287, 16.198801, 0.000000, 0.000000, 178.200012, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2431, 1227.961547, -1425.653686, 15.778807, 0.000000, 0.000000, 179.400085, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2642, 1225.249511, -1425.338256, 16.198801, 0.000000, 0.000000, 178.200012, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19362, 1224.921997, -1430.338623, 11.864742, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2740, 1227.959838, -1426.175170, 15.668808, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2740, 1225.750244, -1426.175170, 15.668808, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2740, 1229.949829, -1426.175170, 15.668808, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1221.909545, -1428.419433, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1221.909545, -1427.239013, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1221.909545, -1426.058471, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2416, 1227.911743, -1428.184448, 12.508806, 0.000000, 0.000000, 179.700012, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1216.638427, -1426.058471, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1216.638427, -1428.449218, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1216.638427, -1427.248657, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1211.318603, -1426.058471, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1211.318603, -1427.238159, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2168, 1211.318603, -1428.427856, 12.524741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1218.812377, -1426.774780, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1213.552124, -1426.774780, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1208.520874, -1426.774780, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1222.950439, -1426.774780, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1228.281982, -1426.774780, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1228.281982, -1419.994873, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1223.091796, -1420.045410, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1216.741455, -1420.045410, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16779, 1211.221191, -1420.045410, 18.544769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2456, 1220.484741, -1428.530639, 15.584737, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2456, 1213.664428, -1428.530639, 15.584737, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2456, 1208.714599, -1428.530639, 15.584737, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1371, 1209.982055, -1428.332641, 13.308806, 0.000000, 0.000000, -178.899993, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1371, 1209.012329, -1428.351318, 13.308806, 0.000000, 0.000000, -178.899993, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19825, 1231.971679, -1422.903930, 15.918805, 0.000000, 0.000000, -89.999954, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1775, 1231.596435, -1423.311157, 13.598807, 0.000000, 0.000000, -88.699981, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1775, 1231.562500, -1421.811401, 13.598807, 0.000000, 0.000000, -88.699981, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1775, 1231.523437, -1420.081665, 13.598807, 0.000000, 0.000000, -88.699981, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19076, 1247.246704, -1428.039550, 12.281659, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

    //JACK
	tmpobjid = CreateDynamicObject(19482, 753.367797, -1431.037109, 16.773437, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "18s Los Santos", 50, "Webdings", 19, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 758.367797, -1431.037109, 16.773437, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "Cruel Killer", 50, "Webdings", 19, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 758.367797, -1431.037109, 16.773437, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "Cruel Killer", 50, "Webdings", 19, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 758.367797, -1431.037109, 16.773437, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "Cruel Killer", 50, "Webdings", 19, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 753.367797, -1431.037109, 16.773437, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "18s Los Santos", 50, "Webdings", 19, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 753.367797, -1431.037109, 16.773437, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "18s Los Santos", 50, "Webdings", 19, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 743.092102, -1443.331909, 14.539061, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "FUCK POLICE", 50, "Ariel", 15, 0, 0xFF0000FF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 743.092102, -1443.331909, 14.539061, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "FUCK POLICE", 50, "Ariel", 15, 0, 0xFF0000FF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19482, 743.092102, -1443.331909, 14.539061, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(tmpobjid, 0, "FUCK POLICE", 50, "Ariel", 15, 0, 0xFF0000FF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19868, 766.180114, -1424.300415, 12.526026, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19868, 771.180114, -1424.300415, 12.526026, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(19980, 761.388732, -1428.965209, 12.523436, 0.000000, 0.000000, 45.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2695, 758.310546, -1428.985717, 14.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2695, 754.710571, -1428.985717, 14.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2695, 751.010620, -1428.985717, 14.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2695, 747.210632, -1428.985717, 14.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1728, 748.318359, -1429.415893, 12.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2315, 751.535217, -1429.486938, 12.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1728, 754.118347, -1429.415893, 12.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1594, 748.513793, -1435.290039, 13.023436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2047, 752.820678, -1429.042846, 14.123436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(14781, 739.573791, -1444.108032, 17.795312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19831, 762.305603, -1444.897583, 12.086948, 0.000000, 0.000000, 222.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1209, 744.007446, -1429.234375, 12.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(3761, 733.931030, -1429.727783, 13.839061, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(16151, 738.814697, -1439.717285, 12.859062, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1665, 752.551391, -1429.525756, 13.073436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1668, 751.641906, -1429.766723, 13.173437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1487, 753.184631, -1429.406860, 13.223437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2706, 745.780029, -1429.002929, 15.623435, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1281, 762.327026, -1449.148193, 13.007555, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(1281, 762.327026, -1453.148193, 13.007555, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(3524, 741.342163, -1429.533935, 12.523436, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(2672, 750.952331, -1433.348754, 12.823437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(4641, 762.393493, -1426.004028, 14.023437, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	tmpobjid = CreateDynamicObject(19972, 712.501525, -1416.574951, 12.531168, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00);
	//Pesawat terjun
	CreateObject(14548, 1387.15552, -2543.55566, 1200.22058,   14.00000, 0.00000, -90.00000);

	//ext
	CreateDynamicObject(18980, -8.57880, -268.51450, -1.53790,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18980, 3.92030, -268.53720, -1.53790,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18980, -75.62430, -346.66879, -6.25150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18980, -75.51630, -359.86221, -6.53550,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18980, -75.62430, -345.68179, -6.25150,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18980, -75.51630, -358.92221, -6.53550,   0.00000, 0.00000, 0.00000);

	//Toll - Flint
	CreateObject(8168, 61.25604, -1533.39465, 6.10425,   0.00000, 0.00000, 9.92526);
	CreateObject(8168, 40.96660, -1529.57251, 6.10425,   0.00000, 0.00000, 188.57129);
	CreateObject(966, 35.88975, -1526.00964, 4.24106,   0.00000, 0.00000, 270.67566);
	CreateObject(966, 67.09373, -1536.82751, 3.99106,   0.00000, 0.00000, 87.33780);
	CreateObject(973, 52.97949, -1531.92529, 5.09049,   0.00000, 0.00000, 352.06006);
	CreateObject(973, 49.04207, -1531.50659, 5.17587,   0.00000, 0.00000, 352.05688);

	//Toll - LV
	CreateObject(8168, 1789.83203, 703.18945, 15.84637,   0.00000, 3.00000, 99.24951);
	CreateObject(8168, 1784.83350, 703.94800, 16.07064,   0.00000, 357.00000, 278.61096);
	CreateObject(966, 1781.41223, 697.32532, 14.63691,   0.00000, 0.00000, 348.09009);
	CreateObject(966, 1793.42896, 709.87982, 13.63691,   0.00000, 0.00000, 169.43665);
	CreateObject(973, 1771.58691, 702.35260, 15.03000,   0.00000, 0.00000, 131.87990);
	CreateObject(973, 1804.35840, 710.90863, 13.90900,   0.00000, 0.00000, 206.40012);
	CreateObject(970, 1781.71448, 699.19360, 14.93310,   0.00000, 0.00000, 79.26010);
	CreateObject(970, 1792.94360, 707.78748, 14.22510,   0.00000, 0.00000, 79.80003);

	Tflint[0] = CreateDynamicObject(968, 35.838928222656, -1525.9034423828, 5.0012145042419, 0.000000, -90.000000, 270.67565917969, -1);
	Tflint[1] = CreateDynamicObject(968, 67.116600036621, -1536.8218994141, 4.7504549026489, 0.000000, -90.000000, 87.337799072266, -1);

	TollLv[0] = CreateDynamicObject(968, 1781.4133300781, 697.31750488281, 15.420023918152, 0.000000, -90.000000, 348.10229492188, -1);
	TollLv[1] = CreateDynamicObject(968, 1793.6700439453, 709.84631347656, 14.405718803406, 0.000000, -90.000000, 169.43664550781, -1);

    pTollArea[0] = CreateDynamicSphere(40.3993, -1522.9064, 5.1910, 4.0, -1, -1);
	pTollArea[1] = CreateDynamicSphere(62.3336, -1540.1075, 5.0645, 4.0, -1, -1);
	pTollArea[2] = CreateDynamicSphere(1795.9447, 704.2550, 15.0006, 4.0, -1, -1);
	pTollArea[3] = CreateDynamicSphere(1778.9886, 702.6728, 15.2574, 4.0, -1, -1);

    //trasher
	new label[128];
	for(new i; i < sizeof(TrashData); i++)
	{
	    format(label, sizeof(label), "%s\n{FFFFFF}\n/trash /pickup to drop trash or collect trash.", (TrashData[i][TrashType] == TYPE_BIN) ? ("Trash Bin") : ("Dumpster"));
		TrashData[i][TrashLabel] = CreateDynamic3DTextLabel(label, 0x2ECC71FF, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]+1.25, 15.0, .testlos = 1);
		TrashData[i][TrashLevel] = (TrashData[i][TrashType] == TYPE_BIN) ? 1 : 2;
	}
	for(new i; i < sizeof(FactoryData); i++)
	{
	    format(label, sizeof(label), "Recycling Factory - %s\n\n{FFFFFF}Current Trash Bags: {F39C12}0\n{FFFFFF}Bring trash here to earn money!", FactoryData[i][FactoryName]);
		FactoryData[i][FactoryLabel] = CreateDynamic3DTextLabel(label, 0x2ECC71FF, FactoryData[i][FactoryX], FactoryData[i][FactoryY], FactoryData[i][FactoryZ] + 0.5, 15.0, .testlos = 1);
		FactoryData[i][FactoryCP] = CreateDynamicCP(FactoryData[i][FactoryX], FactoryData[i][FactoryY], FactoryData[i][FactoryZ], 6.0);
	}

	for(new i, m = GetPlayerPoolSize(); i <= m; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
		Trash_InitPlayer(i);
	}
	//electric
	for(new i; i < sizeof(ElectricData); i++)
	{
	    format(label, sizeof(label), "Electrican Point\n/services to service.");
		ElectricData[i][ElectricLabel] = CreateDynamic3DTextLabel(label, 0x2ECC71FF, ElectricData[i][ElectricX], ElectricData[i][ElectricY], ElectricData[i][ElectricZ]+1.25, 15.0, .testlos = 1);
	}
	tangga1 = CreateDynamicObject(1428, -770.86072, 2740.76587, 42.99480,   13.00000, 0.00000, 0.00000);
	tangga2 = CreateObject(1428, -1462.87024, 2527.30664, 53.48190,   7.00000, 0.00000, -130.00000);

    LSApartments1Object = CreateObject(19595, 1160.96, -1180.58, 70.4141, 0, 0, 0);

    // Create the LS Apartments 1 Car Park object
    LSApartments1CPObject = CreateObject(19798, 1160.96, -1180.58, 20.4141, 0, 0, 0);

    // Reset the elevator queue
	ResetElevatorQueue();

	// Create the elevator object, the elevator doors and the floor doors
	Elevator_Initialize();

    // Loop
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        // Check if the player is connected and not a NPC
        if (IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            // Remove default GTASA building map object, LOD and awning shadows
            // (so any player currently ingame does not have to rejoin for them
			//  to be removed when this filterscript is loaded)
			RemoveBuildingForPlayer(i, 5766, 1160.96, -1180.58, 70.4141, 250.0); // Awning shadows
			RemoveBuildingForPlayer(i, 5767, 1160.96, -1180.58, 70.4141, 250.0); // Building
			RemoveBuildingForPlayer(i, 5964, 1160.96, -1180.58, 70.4141, 250.0); // LOD
        }
    }

	//Auction
	AuctionText = CreateDynamicObject(18244, 189.572525, -80.501548, 1032.988037, 89.999946, -0.499999, 0.699999, -1, -1, -1, 250.00, 250.00);
	SetDynamicObjectMaterialText(AuctionText, 0, "{FFFF00}Welcome\nTo Los Santos\n{FFFF00}Auction Office", 90, "Ariel", 20, 1, 0x00000000, 0x00000001, 1);
	HighBidText = CreateDynamicObject(3077, 195.396118, -81.974838, 1030.729858, 0.000000, 0.000000, -36.599998, -1, -1, -1, 300.00, 300.00);
	//hydr
	hydr[0] = CreateDynamicObject(19817, 2193.24243, -2199.99780, 10.96290,   0.00000, 0.00000, 44.40000);
	hydr[1] = CreateDynamicObject(19817, 2199.55225, -2193.81885, 10.96290,   0.00000, 0.00000, 44.40000);
	hydr[2] = CreateDynamicObject(19817, 2186.67017, -2206.51807, 10.96290,   0.00000, 0.00000, 44.04000);
	hydr[3] = CreateDynamicObject(19817, 2201.54321, -2237.80566, 10.88290,   0.00000, 0.00000, -136.98000);
	hydr[4] = CreateDynamicObject(19817, 2208.19092, -2231.78809, 10.86690,   0.00000, 0.00000, -136.98000);
	hydr[5] = CreateDynamicObject(19817, 2214.58667, -2225.68530, 10.85890,   0.00000, 0.00000, -136.98000);

	objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
	//----------------------------------------------------------------------------------------------------
    CreateDynamicObject(19379, 1435.35657, -1227.07996, 151.31239,   360.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1424.86401, -1227.07996, 151.31239,   360.00000, 90.00000, 1080.00000);
	g_Discord_AndroVerifed = DCC_FindChannelById("916571244428660738");
	g_discord_server = DCC_FindChannelById("899303664236232744");
	g_discord_twt = DCC_FindChannelById("913718511426216016");
	g_Discord_Kill = DCC_FindChannelById("926854272174399558");
	g_discord_ban = DCC_FindChannelById("898822230430081064");
	g_discord_admins = DCC_FindChannelById("864854692831952936");
	g_Discord_samp = DCC_FindChannelById("927787077754560562");
	g_discord_botcmd = DCC_FindChannelById("914509821171101756");
	g_Discord_logswl = DCC_FindChannelById("927830873494147113");
	g_discord_logs = DCC_FindChannelById("926854926288699432");

	//Butcher
    new obuther = CreateDynamicObject(1439, 944.436828, 2127.660644, 1010.021179, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(obuther, 0, 2803, "cj_meaty", "CJ_FLESH_2", 0x00000000);
	CreatePickup(1275, 23, 960.7062,2099.4375,1011.0248,0);
	meatsp = CreateDynamicSphere(960.7062,2099.4375,1011.0248, 2.0);

	CreateDynamic3DTextLabel("Start Work: {f7ae11}H",0xFFFFFFFF,940.1020,2127.6326,1011.0303,5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0, 0);

	//-------------------------------------------------

	SpawnMale = LoadModelSelectionMenu("spawnmale.txt");
	SpawnFemale = LoadModelSelectionMenu("spawnfemale.txt");
	MaleSkins = LoadModelSelectionMenu("maleskin.txt");
	FemaleSkins = LoadModelSelectionMenu("femaleskin.txt");
	VIPMaleSkins = LoadModelSelectionMenu("maleskin.txt");
	VIPFemaleSkins = LoadModelSelectionMenu("femaleskin.txt");
	SAPDMale = LoadModelSelectionMenu("sapdmale.txt");
	SAPDFemale = LoadModelSelectionMenu("sapdfemale.txt");
	SAPDWar = LoadModelSelectionMenu("sapdwar.txt");
	SAGSMale = LoadModelSelectionMenu("sagsmale.txt");
	SAGSFemale = LoadModelSelectionMenu("sagsfemale.txt");
	SAMDMale = LoadModelSelectionMenu("samdmale.txt");
	SAMDFemale = LoadModelSelectionMenu("samdfemale.txt");
	SANEWMale = LoadModelSelectionMenu("sanewmale.txt");
	SANEWFemale = LoadModelSelectionMenu("sanewfemale.txt");
	toyslist = LoadModelSelectionMenu("toys.txt");
	rentjoblist = LoadModelSelectionMenu("rentjoblist.txt");
	sportcar = LoadModelSelectionMenu("sportcar.txt");
 	boatlist = LoadModelSelectionMenu("boatlist.txt");
	viptoyslist = LoadModelSelectionMenu("viptoys.txt");
	vtoylist = LoadModelSelectionMenu("vtoylist.txt");

	SAGSLobbyBtn[0] = CreateButton(1388.987670, -25.291969, 1001.358520, 180.000000);
	SAGSLobbyBtn[1] = CreateButton(1391.275756, -25.481920, 1001.358520, 0.000000);
	SAGSLobbyDoor = CreateDynamicObject(1569, 1389.375000, -25.387500, 999.978210, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

	SAPDLobbyBtn[0] = CreateButton(252.95264, 107.67332, 1004.00909, 264.79898);
	SAPDLobbyBtn[1] = CreateButton(253.43437, 110.62970, 1003.92737, 91.00000);
	SAPDLobbyDoor[0] = CreateDynamicObject(1569, 253.10965, 107.61060, 1002.21368,   0.00000, 0.00000, 91.00000);
	SAPDLobbyDoor[1] = CreateDynamicObject(1569, 253.12556, 110.49657, 1002.21460,   0.00000, 0.00000, -91.00000);

	SAPDLobbyBtn[2] = CreateButton(239.82739, 116.12640, 1004.00238, 91.00000);
	SAPDLobbyBtn[3] = CreateButton(238.75888, 116.12949, 1003.94086, 185.00000);
	SAPDLobbyDoor[2] = CreateDynamicObject(1569, 239.69435, 116.15908, 1002.21411,   0.00000, 0.00000, 91.00000);
	SAPDLobbyDoor[3] = CreateDynamicObject(1569, 239.64050, 119.08750, 1002.21332,   0.00000, 0.00000, 270.00000);

	//Family Button
	LLFLobbyBtn[0] = CreateButton(-2119.90039, 655.96808, 1062.39954, 184.67528);
	LLFLobbyBtn[1] = CreateButton(-2119.18481, 657.88519, 1062.39954, 90.00000);
	LLFLobbyDoor = CreateDynamicObject(1569, -2119.21509, 657.54187, 1060.73560,   0.00000, 0.00000, -90.00000);

	printf("[Object] Number of Dynamic objects loaded: %d", CountDynamicObjects());
    new DCC_Channel:channell, DCC_Embed:logss;
	new y, m, d, timestamp[200];
	getdate(y, m , d);
	channell = DCC_FindChannelById("934415585754882069");
	format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
	logss = DCC_CreateEmbed("LegacyPride Roleplay");
	DCC_SetEmbedTitle(logss, "LegacyPride");
	DCC_SetEmbedTimestamp(logss, timestamp);
	DCC_SetEmbedColor(logss, 0x00ff00);
	DCC_SetEmbedUrl(logss, "https://gta-legacypride.id");
	DCC_SetEmbedFooter(logss, "LEGACY PRIDE ROLEPLAY", "");
	new stroi[5000];
	format(stroi, sizeof(stroi), "Server Kembali Online @everyone");
	DCC_AddEmbedField(logss, "Server Status", stroi, true);
	DCC_SendChannelEmbedMessage(channell, logss);

	for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        OnPlayerConnect(i);
    }
	return 1;
}

public OnGameModeExit()
{
	print("-------------- [ Auto Gmx ] --------------");
	new count = 0, count1 = 0, user = 0;
	KillTimer(FlashTimer);
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station] Number of Saved: %d", count);

	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	printf("[Farmer Plant] Number of Saved: %d", count1);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	//trasher
	for(new i, m = GetPlayerPoolSize(); i <= m; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    Trash_ResetPlayer(i, 1);
	}
	foreach(new i : Player)
	{
		user++;
		UpdatePlayerData(i);
	}
	printf("[Database] User Saved: %d", user);
	print("-------------- [ Auto Gmx ] --------------");
	SendClientMessageToAll(COLOR_RED, "[!]"YELLOW_E" Sorry Server is Maintenance/Restart.{00FFFF} ~LEGACY BOTS");

        // Check for valid object
	if (IsValidObject(LSApartments1Object))
	{
		// Destroy the LS Apartments 1 Building object
		DestroyObject(LSApartments1Object);
	}

    // Check for valid object
	if (IsValidObject(LSApartments1CPObject))
	{
		// Destroy the LS Apartments 1 Car Park object
		DestroyObject(LSApartments1CPObject);
	}

    // Destroy the elevator, the elevator doors and the elevator floor doors
	Elevator_Destroy();

	UnloadTazerSAPD();
	SaveActors();
	//Audio_DestroyTCPServer();
	mysql_close(g_SQL);
    new DCC_Channel:channell, DCC_Embed:logss;
	new y, m, d, timestamp[200];
	getdate(y, m , d);
	channell = DCC_FindChannelById("934415585754882069");
	format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
	logss = DCC_CreateEmbed("LegacyPride Roleplay");
	DCC_SetEmbedTitle(logss, "LegacyPride");
	DCC_SetEmbedTimestamp(logss, timestamp);
	DCC_SetEmbedColor(logss, 0xff0000);
	DCC_SetEmbedUrl(logss, "https://gta-legacypride.id");
	DCC_SetEmbedFooter(logss, "LEGACY PRIDE ROLEPLAY", "");
	new stroi[5000];
	format(stroi, sizeof(stroi), "Server Maintenance Harap Sabar @everyone");
	DCC_AddEmbedField(logss, "Server Status", stroi, true);
	DCC_SendChannelEmbedMessage(channell, logss);
	return 1;
}

forward Stats(playerid);
public Stats(playerid)
{
   new statuz[1200];
   format(statuz,sizeof(statuz),"", Iter_Count(Player));
   DCC_SetBotActivity(statuz);
}

public OnPlayerPressButton(playerid, buttonid)
{
	if(buttonid == SAGSLobbyBtn[0] || buttonid == SAGSLobbyBtn[1])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor, 1387.9232, -25.3887, 999.9782, 3);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Access denied.");
			return 1;
		}
	}
	if(buttonid == SAPDLobbyBtn[0] || buttonid == SAPDLobbyBtn[1])
	{
		if(pData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[0], 253.14204, 106.60210, 1002.21368, 3);
			MoveDynamicObject(SAPDLobbyDoor[1], 253.24377, 111.94370, 1002.21460, 3);
			SetTimer("SAPDLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Access denied.");
			return 1;
		}
	}
	if(buttonid == SAPDLobbyBtn[2] || buttonid == SAPDLobbyBtn[3])
	{
		if(pData[playerid][pFaction] == 1)
		{
			MoveDynamicObject(SAPDLobbyDoor[2], 239.52385, 114.75534, 1002.21411, 3);
			MoveDynamicObject(SAPDLobbyDoor[3], 239.71977, 120.21591, 1002.21332, 3);
			SetTimer("SAPDLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Access denied.");
			return 1;
		}
	}
	if(buttonid == LLFLobbyBtn[0] || buttonid == LLFLobbyBtn[1])
	{
		if(pData[playerid][pFamily] == 0)
		{
			MoveDynamicObject(LLFLobbyDoor, -2119.27148, 656.04028, 1060.73560, 3);
			SetTimer("LLFLobbyDoorClose", 5000, 0);
		}
		else
		{
			Error(playerid, "Access denied.");
			return 1;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		/*if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SAPD!");
			}
		}*/
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SAGS!");
			}
		}/*
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SAMD!");
			}
		}*/
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "You are not SANEW!");
			}
		}
		if(GetVehicleModel(vehicleid) == 548 || GetVehicleModel(vehicleid) == 417 || GetVehicleModel(vehicleid) == 487 || GetVehicleModel(vehicleid) == 488 ||
		GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 563 || GetVehicleModel(vehicleid) == 469)
		{
			if(pData[playerid][pLevel] < 5)
			{
				RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				Error(playerid, " Anda tidak memiliki izin!");
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
    new fmt_str[128];
    format(fmt_str, sizeof fmt_str, "```%s Says: %s```", pData[playerid][pName], text);
    DCC_SendChannelMessage(g_discord_logs, fmt_str);

	if(isnull(text)) return 0;
	printf("[CHAT] %s(%d) : %s", pData[playerid][pName], playerid, text);

	if(pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	text[0] = toupper(text[0]);
	//
	/*if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s take the weapon off the belt and ready to shoot anytime.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpsavegun", true) || !strcmp(text, "savegunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s safe a weapon in dueffel bag.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s shocked after crash.", ReturnName(playerid));
		return 0;
	}*/
	//
	if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s take the weapon off the belt and ready to shoot anytime.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpsavegun", true) || !strcmp(text, "savegunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s safe a weapon in dueffel bag.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s shocked after crash.", ReturnName(playerid));
		return 0;
	}
	if(pData[playerid][pAdminDuty] == 1)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s: "WHITE_E"(( %s ))", pData[playerid][pAdminname], text);
		SetPlayerChatBubble(playerid, text, COLOR_RED, 10.0, 3000);
		return 0;
	}
	if(text[0] == '@')
	{
		if(pData[playerid][pSMS] != 0)
		{
			if(pData[playerid][pPhoneCredit] < 1)
			{
				Error(playerid, "You dont have phone credits!");
				return 0;
			}
			if(pData[playerid][pInjured] != 0)
			{
				Error(playerid, "You cant do at this time.");
				return 0;
			}
			new tmp[512];
			if(text[0] == '!')
			{
				if(text[1] == ' ')
				{
			 		format(tmp, sizeof(tmp), "%s", text[2]);
				}
				else
				{
				    format(tmp, sizeof(tmp), "%s", text[1]);
				}
				if(pData[playerid][pPhone] == pData[playerid][pSMS])
				{
					if(playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid))
					{
						Error(playerid, "This number is not actived!");
						return 0;
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", pData[playerid][pSMS], tmp);
					SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], tmp);
					PlayerPlaySound(playerid, 6003, 0,0,0);
					pData[playerid][pSMS] = pData[playerid][pPhone];

					pData[playerid][pPhoneCredit] -= 1;
					return 0;
				}
			}
		}
	}
	if(GetPVarInt(playerid,"911"))
    {
		new Float:x, Float:y, Float:z, String[100];
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for emergency crime only! please wait for SAPD respon!");
		SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		format(String, sizeof(String), "[Description]: "WHITE_E"%s", text);
		SendFactionMessage(1, COLOR_BLUE, String);
		DeletePVar(playerid, "911");
		return 0;
	}
	if(GetPVarInt(playerid,"922"))
    {
		new Float:x, Float:y, Float:z, String[100];
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Warning: This number for emergency medical only! please wait for SAMD respon!");
		SendFactionMessage(3, COLOR_PINK2, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency medical! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
		format(String, sizeof(String), "[Description]: "WHITE_E"%s", text);
		SendFactionMessage(1, COLOR_PINK2, String);
		DeletePVar(playerid, "922");
		return 0;
	}
	if(GetPVarInt(playerid,"933"))
    {
		new Float:x, Float:y, Float:z, String[100];
		GetPlayerPos(playerid, x, y, z);
		Info(playerid, "Your calling has sent to the taxi driver. please wait for respon!");
		foreach(new tx : Player)
		{
			if(pData[tx][pJob] == 1 || pData[tx][pJob2] == 1)
			{
				SendClientMessageEx(tx, COLOR_YELLOW, "[TAXI CALL] "WHITE_E"%s calling the taxi for order! Ph: ["GREEN_E"%d"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
                format(String, sizeof(String), "[Description]: "WHITE_E"%s", text);
				SendFactionMessage(1, COLOR_YELLOW, String);
			}
		}
		DeletePVar(playerid, "933");
		return 0;
	}
	new sgm[128];
	foreach(new i : Player)
	if(pData[playerid][pUsingWT] == 1)
   	{
        if(pData[i][pWT] == pData[playerid][pWT])
        {
			SendClientMessageEx(i, COLOR_LIME, "[WT:%d] "YELLOW_E"%s: %s", pData[playerid][pWT], ReturnName(playerid), text);
			format(sgm, sizeof(sgm), "[<WT>]\n* %s *", sgm);
			SetPlayerChatBubble(i, sgm, COLOR_LBLUE, 5.0, 5000);
        }
	}
	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
	{

		UpperToLower(text);
		new lstr[1024];
		format(lstr, sizeof(lstr), "(cellphone) %s says: %s", ReturnName(playerid), text);
		ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);

		SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "[CELLPHONE] "WHITE_E"%s.", text);
		return 0;
	}
	else SendMessageInChat(playerid, text);
	return 0;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        Error(playerid, " unknown command use'/help'", cmd);
        return 0;
    }
	printf("[CMD]: %s(%d) has used the command '%s' (%s)", pData[playerid][pName], playerid, cmd, params);
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);

    return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == phTextD[20][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
		strcat(EnteredPhoneNumb[playerid], "1");
		PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[21][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
		strcat(EnteredPhoneNumb[playerid], "2");
		PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[22][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
		strcat(EnteredPhoneNumb[playerid], "3");
		PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[23][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
       	strcat(EnteredPhoneNumb[playerid], "4");
       	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[24][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
       	strcat(EnteredPhoneNumb[playerid], "5");
       	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[25][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
       	strcat(EnteredPhoneNumb[playerid], "6");
       	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[26][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
       	strcat(EnteredPhoneNumb[playerid], "7");
       	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[27][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
       	strcat(EnteredPhoneNumb[playerid], "8");
       	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[28][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
       	strcat(EnteredPhoneNumb[playerid], "9");
    	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[29][playerid])
    {
        PlayerPlaySound(playerid, 1058, 0, 0, 0);
        strcat(EnteredPhoneNumb[playerid], "0");
    	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[30][playerid])
    {
		new numbs = strlen(EnteredPhoneNumb[playerid]);

        if(numbs == 1) strdel(EnteredPhoneNumb[playerid], 0, 1);
        if(numbs == 2) strdel(EnteredPhoneNumb[playerid], 1, 2);
        if(numbs == 3) strdel(EnteredPhoneNumb[playerid], 2, 3);
        if(numbs == 4) strdel(EnteredPhoneNumb[playerid], 3, 4);
        if(numbs == 5) strdel(EnteredPhoneNumb[playerid], 4, 5);
        if(numbs == 6) strdel(EnteredPhoneNumb[playerid], 5, 6);

        PlayerPlaySound(playerid, 1137, 0, 0, 0);
    	PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
    }

    if(playertextid == phTextD[31][playerid])
    {
		if(!CallingNum[playerid])
		{
			PlayerPlaySound(playerid, 3600, 0, 0, 0);
			CallingNum[playerid] = true;

			PlayerTextDrawSetString(playerid, phTextD[5][playerid], "Dialing");
			PlayerTextDrawSetString(playerid, phTextD[31][playerid], "~r~h");
		}

		else if(CallingNum[playerid])
		{
        	PlayerPlaySound(playerid, 1058, 0, 0, 0);
			CallingNum[playerid] = false;

			PlayerTextDrawSetString(playerid, phTextD[5][playerid], EnteredPhoneNumb[playerid]);
			PlayerTextDrawSetString(playerid, phTextD[31][playerid], "~g~c");
		}

    }
    if(playertextid == EditVObjTD[playerid][4])
    {
    	if(IsPlayerInAnyVehicle(playerid))
    	{
    		HideEditVehicleTD(playerid);
    		new x = GetPlayerVehicleID(playerid);
    		foreach(new i: PVehicles)
			{
				if(x == pvData[i][cVeh])
				{
    				MySQL_SaveVehicleToys(i);
    			}
    		}
    	}
    }
    else if(playertextid == EditVObjTD[playerid][6])
    {
    	HideEditVehicleTD(playerid);
    	Info(playerid, "You has canceled edit vehicle toys position");
    }
    else if(playertextid == EditVObjTD[playerid][2])
    {
    	AddVObjPos(playerid);
    }
    else if(playertextid == EditVObjTD[playerid][3])
    {
    	SubVObjPos(playerid);
    }
    else if(playertextid == EditVObjTD[playerid][7])
    {
    	ShowPlayerDialog(playerid, VTOYSET_VALUE, DIALOG_STYLE_INPUT, "Vehicle Toy PosX", "Set current float value\nNormal Value = 0.05\n\nEnter Float NudgeValue in here:", "Edit", "Cancel");
    }
    else if(playertextid == ToysTDsave[playerid])
    {
    	HideEditToysTD(playerid);
    	SetPVarInt(playerid, "UpdatedToy", 1);
    	Info(playerid, "You has saved toys position");
    }
    else if(playertextid == ToysTDup[playerid])
    {
    	AddTObjPos(playerid);
    }
    else if(playertextid == ToysTDdown[playerid])
    {
    	SubTObjPos(playerid);
    }
    else if(playertextid == ToysTDedit[playerid])
    {
    	ShowPlayerDialog(playerid, TOYSET_VALUE, DIALOG_STYLE_INPUT, "Vehicle Toy PosX", "Set current float value\nNormal Value = 0.05\n\nEnter Float NudgeValue in here:", "Edit", "Cancel");
    }
    return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(pData[playerid][pAdminDuty])
	{
		SetPVarFloat(playerid, "pointx", fX+10);
		SetPVarFloat(playerid, "pointy", fY+10);
		SetPVarFloat(playerid, "pointz", fZ+10);
		pData[playerid][pClickMap] = 1;
		Info(playerid, "Kamu menset point dimap, gunakan /tpm untuk bertelportasi ke point");
	}
	return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (!strcmp(cmdtext, "/pcmds"))
	{
		SendClientMessage(playerid, 0x12FF12AA, "/pwork for work, /pwstop for stopping work, /phelp for some help.");
		return 1;
	}
	if (!strcmp(cmdtext, "/pwork"))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new strin[45];
 			format(strin, sizeof(strin), "%i, %i, %i", pilotvehs[0], pilotvehs[1], pilotvehs[2]);
 			SendClientMessage(playerid, -1, strin);
 			new bool:IsPassing[MAX_PLAYERS] = false;
 			for (new o; o < 9; o++)
			{
    			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == pilotvehs[o])
				{
					// 476 Rustler
					rands = random(sizeof(RandomCPs));
    				SendClientMessage(playerid, 0x34AA33AA, "As you were in your plane. An airport officer noticed you then he approached you.");
	 				cp[playerid] = SetPlayerCheckpoint(playerid, RandomCPs[rands][0],RandomCPs[rands][1],RandomCPs[rands][2], 5.0);

	 				TakingPs[playerid] = 1;
	 				IsPassing[playerid] = true;
	 				return 1;
				}
			}
   			if(IsPassing[playerid] == false) {
			    SendClientMessage(playerid, 0xFF6347AA, "Please use planes. Hydra and Rustler not included in planes category.");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF6347AA, "Please get in a plane and then start your work.");
		}
		return 1;
	}
	if(!strcmp(cmdtext, "/phelp"))
	{
	    new phstr[256];
	    format(phstr, sizeof(phstr),  "If you want to became a pilot then worry not we have\n some thing for you, just get in a plane and use /pwork.\n While you are doing your work you will also be \ngiven your payment it is %i per trip. So, have fun and fly just\n one.In last, use /pwstop to stop.", WorkBucks);
	    ShowPlayerDialog(playerid, PH_D, DIALOG_STYLE_MSGBOX, "Pilots Work Help", phstr, "OK", "Cancel");
	    return 1;
	}

	if(!strcmp(cmdtext, "/pwstop"))
	{
		SendClientMessage(playerid, 0xFFFF00AA, "He said: OK! you are out of duty. Have fun in your life.");
	    DestroyDynamicCP(cp[playerid]);
	    TakingPs[playerid] = 2;
	    return 1;
	}
	return 0;
}

public OnPlayerConnect(playerid)
{
	new hour, minute;
	gettime(hour, minute);
	online++;
	togtextdraws[playerid] = 0;
	new PlayerIP[16];
	g_MysqlRaceCheck[playerid]++;

	SetPlayerWeather(playerid, weather_id);

	ResetVariables(playerid);
	CreatePlayerTextDraws(playerid);

	GetPlayerName(playerid, pData[playerid][pName], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	pData[playerid][pIP] = PlayerIP;
    new playerip[320], extraid;
	new kota[1401], negara[1401];
	GetPlayerCity(extraid, kota, sizeof(kota));
	GetPlayerCountry(extraid, negara, sizeof(negara));
	GetPlayerIp(extraid, playerip, sizeof(playerip));
	format(pData[extraid][pIP], 32, "%s", playerip);

	SetTimerEx("SafeLogin", 5000, 0, "i", playerid);

	CheckUCP(playerid);	SetPlayerColor(playerid, COLOR_WHITE);

	//---[ Function ]---
    pBlind[playerid] = 0;
	SedangHauling[playerid] = 0;
	DeletePVar(playerid,"MeatCheck");
	pPurchaseCargoSeed[playerid] = 0;
	pPurchaseCargoMeat[playerid] = 0;
	SedangAnterPizza[playerid] = 0;
	pCargo[playerid] = 0;
	IsAtEvent[playerid] = 0;
	PlayerPBing[playerid] = false;
    PlayerPBKills[playerid] = 0;
    pData[playerid][pToggleAtm] = 0;
	//---------
	Trash_InitPlayer(playerid);
	//--------------------

    new string[128];
    format(string, sizeof string, "Player ID %d",playerid);
    new DCC_Embed:apalah;
 	new str[526],stro[526];
 	format(str,sizeof(str),"%s", GetPlayerNameEx(playerid));
 	format(stro,sizeof(stro),"%d/%d",online,GetMaxPlayers());
	apalah = DCC_CreateEmbed("LEGACY PRIDE ROLEPLAY","Player Connect","","",0x00ff00,"Join us @gta-legacypride.id","","","");
	DCC_AddEmbedField(apalah, str, string, true);
	DCC_AddEmbedField(apalah, "Current Player", stro, true);
	DCC_SendChannelEmbedMessage(g_discord_server, apalah);
	//progres barr
	pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 280.000000, 390.000000, 100.000000, 20.000000, 2094792959, 100.000000, 0);
	//pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 281.000000, 136.000000, 88.000000, 10.500000, -1061109611, 100, 0);
	//HBE textdraw Modern
	/*pData[playerid][damagebar] = CreatePlayerProgressBar(playerid, 355.000000, 426.000000, 60.000000, 12.000000, 16711935, 100.000000, 0);
	pData[playerid][fuelbar] = CreatePlayerProgressBar(playerid, 355.000000, 400.000000, 60.000000, 12.000000, 16711935, 100.000000, 0);

	pData[playerid][hungrybar] = CreatePlayerProgressBar(playerid, 523.000000, 400.000000, 75.000000, 15.000000, 9109759, 100.000000, 0);
	pData[playerid][energybar] = CreatePlayerProgressBar(playerid, 523.000000, 425.000000, 75.000000, 15.000000, 9109759, 100.000000, 0);
*/
	//------------------------ //removebuilding
	//Burger
	RemoveBuildingForPlayer(playerid, 627, 1209.900, -1482.380, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1230.130, -1482.380, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1206.479, -1465.160, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1206.479, -1454.119, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1206.479, -1444.849, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1206.479, -1433.810, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1230.130, -1416.569, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 627, 1209.900, -1416.569, 14.140, 0.250);
	RemoveBuildingForPlayer(playerid, 6052, 1247.910, -1429.969, 15.125, 0.250);
	RemoveBuildingForPlayer(playerid, 6068, 1247.910, -1429.969, 15.125, 0.250);

	//Custom mapping kek mememk
	RemoveBuildingForPlayer(playerid, 4857, 1942.680, -1986.750, 14.898, 0.250);
	RemoveBuildingForPlayer(playerid, 4979, 1942.680, -1986.750, 14.898, 0.250);
	RemoveBuildingForPlayer(playerid, 3625, 1941.979, -1970.699, 14.984, 0.250);

	//Trasher
	RemoveBuildingForPlayer(playerid, 3574, 2226.320, -2168.989, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2226.320, -2168.989, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2241.300, -2183.979, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2241.300, -2183.979, 15.101, 0.250);
	// Roadmaps
	RemoveBuildingForPlayer(playerid, 1290, 1348.010, -1447.920, 18.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1290, 1341.349, -1476.599, 18.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1290, 1329.709, -1498.680, 18.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1290, 1316.660, -1519.270, 18.226, 0.250);
	RemoveBuildingForPlayer(playerid, 1290, 1308.329, -1539.319, 18.226, 0.250);
	//Fish Factory
	RemoveBuildingForPlayer(playerid, 17751, 2844.2422, -1531.8828, 20.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 17551, 2844.2422, -1531.8828, 20.1406, 0.25);
	// Ws Flint
    RemoveBuildingForPlayer(playerid, 785, -54.833, -1201.052, 0.216, 0.250);
	RemoveBuildingForPlayer(playerid, 1447, -107.083, -1196.083, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -112.169, -1194.750, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1413, -101.289, -1215.583, 2.960, 0.250);
	RemoveBuildingForPlayer(playerid, 1447, -100.179, -1210.078, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1413, -102.132, -1197.162, 2.960, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -98.919, -1204.912, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -98.875, -1199.927, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -98.929, -1218.724, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1447, -88.615, -1220.380, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -93.944, -1219.537, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 17066, -86.875, -1207.240, 1.687, 0.250);
	RemoveBuildingForPlayer(playerid, 1413, -83.398, -1221.296, 2.960, 0.250);
	RemoveBuildingForPlayer(playerid, 1447, -78.429, -1208.943, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -79.490, -1214.099, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, -80.294, -1219.078, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 1413, -77.349, -1203.740, 2.802, 0.250);
	RemoveBuildingForPlayer(playerid, 791, -54.833, -1201.052, 0.216, 0.250);
	//removebuild
	RemoveBuildingForPlayer(playerid, 4051, 1371.8203, -1754.8203, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 4021, 1371.8203, -1754.8203, 19.0469, 0.25);
	//electrican
	RemoveBuildingForPlayer(playerid, 1308, -1462.4063, 2527.0078, 54.0547, 0.25);
	//box
	RemoveBuildingForPlayer(playerid, 998, 1464.3203, 1023.2734, 10.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 8311, 1277.2578, 1206.9219, 12.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 8312, 1277.2578, 1206.9219, 12.8281, 0.25);
	//drag
	RemoveBuildingForPlayer(playerid, 4640, 1728.7891, -1065.0938, 24.5000, 0.25);
	//apart
	RemoveBuildingForPlayer(playerid, 5766, 1160.96, -1180.58, 70.4141, 250.0); // Awning shadows
	RemoveBuildingForPlayer(playerid, 5767, 1160.96, -1180.58, 70.4141, 250.0); // Building
	RemoveBuildingForPlayer(playerid, 5964, 1160.96, -1180.58, 70.4141, 250.0); // LOD

	//ms13 ws
	RemoveBuildingForPlayer(playerid, 5821, 1120.3438, -1248.9375, 20.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 5855, 1095.6797, -1212.7813, 18.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 5822, 1123.8203, -1198.8516, 25.7188, 0.25);
	//sa news
	RemoveBuildingForPlayer(playerid, 1226, 642.0938, -1359.8203, 16.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 642.0938, -1334.8516, 16.2734, 0.25);

	//market
	RemoveBuildingForPlayer(playerid, 4191, 1353.2578, -1764.5313, 15.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 4022, 1353.2578, -1764.5313, 15.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1532, 1353.1328, -1759.6563, 12.5000, 0.25);

	//yakuza
	RemoveBuildingForPlayer(playerid, 705, -2491.5859, -670.7188, 138.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 10496, -2501.7891, -701.1875, 227.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 10675, -2529.1875, -705.0391, 141.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 10693, -2528.6563, -672.3047, 139.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2529.2813, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 10676, -2528.6563, -672.3047, 139.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2528.0781, -719.9219, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2524.0156, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2522.8125, -719.9219, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2517.5469, -719.9219, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1596, -2517.5938, -671.0078, 149.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1694, -2518.4297, -632.1953, 155.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2518.7500, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2514.8672, -711.8672, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2514.8672, -706.6328, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2514.8672, -701.3984, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2514.8672, -696.1719, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2514.8672, -690.9375, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2514.8672, -717.0938, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 10357, -2501.7891, -701.1875, 227.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 1684, -2508.5000, -680.9531, 139.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2513.4844, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2508.2188, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1684, -2508.4063, -669.0938, 139.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2502.9531, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2497.6875, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2492.4219, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2487.1563, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2484.2969, -597.1641, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2484.2969, -602.4297, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2484.2969, -607.6953, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2541.5000, -690.9609, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2541.5000, -696.1875, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2541.5000, -701.4219, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2541.5000, -706.6563, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2541.5000, -711.8828, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2541.5000, -717.1172, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2538.6094, -719.9219, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1595, -2538.9297, -648.6406, 152.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1595, -2538.9297, -660.9063, 152.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -2539.8359, -718.3203, 152.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2533.3438, -719.9219, 139.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1695, -2529.6641, -652.6484, 147.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 1695, -2529.6641, -661.9766, 147.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 1695, -2529.6641, -671.3047, 147.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 1695, -2529.6641, -680.6250, 147.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -2537.5938, -620.4688, 145.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2539.8125, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -2534.5469, -594.3281, 133.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1695, -2529.6641, -634.0000, 147.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 1695, -2529.6641, -643.3281, 147.5234, 0.25);

	//mechanic central
	RemoveBuildingForPlayer(playerid, 3686, 2169.1172, -2276.5859, 15.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 3686, 2195.0859, -2216.8438, 15.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 3686, 2220.7813, -2261.0547, 15.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2193.2578, -2286.2891, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2183.1719, -2237.2734, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2174.6406, -2215.6563, 15.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2193.0625, -2196.6406, 15.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 5305, 2198.8516, -2213.9219, 14.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 3747, 2234.3906, -2244.8281, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3747, 2226.9688, -2252.1406, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3747, 2219.4219, -2259.5234, 14.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 3747, 2212.0938, -2267.0703, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3747, 2204.6328, -2274.4141, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2165.0703, -2288.9688, 13.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2193.2578, -2286.2891, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3627, 2169.1172, -2276.5859, 15.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 3569, 2204.6328, -2274.4141, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3569, 2212.0938, -2267.0703, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3627, 2220.7813, -2261.0547, 15.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 3569, 2219.4219, -2259.5234, 14.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2194.4766, -2242.8750, 13.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2217.2188, -2250.3594, 16.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 3569, 2226.9688, -2252.1406, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3569, 2234.3906, -2244.8281, 14.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2183.1719, -2237.2734, 14.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3578, 2235.1641, -2231.8516, 13.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2174.6406, -2215.6563, 15.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 3627, 2195.0859, -2216.8438, 15.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 5244, 2198.8516, -2213.9219, 14.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2193.0625, -2196.6406, 15.1016, 0.25);
    //------------------------------------------------------------------------------------------
    Warning[playerid] = 0;
    VehicleLastEnterTime[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    online--;
    //pb
	if(PlayerPBing[playerid] == true)
	{
		PBPlayers--;
	}
	//end
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);

    if(pData[playerid][pPacket] == 1)
    {
        taked = 0;
        pData[playerid][pPacket]--;
        pCPPacket = INVALID_PLAYER_ID;
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        objectpacket = CreateDynamicObject(11745, X, Y, Z-1, 80.0, 0.0, 0.0, 0);
        taked = 0;
    }
    new string[1280];
    format(string, sizeof string, "ID %d", playerid);
    new str[5260],stra[5260],stro[5260];
	//pilot
	if(TakingPs[playerid] == 1 || TakingPs[playerid] == 0) {
		DestroyDynamicCP(cp[playerid]);
		TakingPs[playerid] = 2;
	}
	//butcher
    if(GetPVarInt(playerid,"InWork"))
	{
	    if(IsValidDynamicObject(playerobject[playerid][0])) DestroyDynamicObject(playerobject[playerid][0]);
	    else if(IsValidDynamicObject(playerobject[playerid][1])) DestroyDynamicObject(playerobject[playerid][1]);
	}
	if(GetPVarType(playerid, "PlacedBB"))
    {
        DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
        DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
        if(GetPVarType(playerid, "BBArea"))
        {
            foreach(new i : Player)
            {
                if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
                {
                    StopAudioStreamForPlayer(i);
                    SendClientMessage(i, COLOR_PURPLE, " The boombox creator has disconnected from the server.");
                }
            }
        }
    }
	DestroyObject(ObjetoC[playerid]);
	DestroyObject(ObjetoC1[playerid]);
	DeletePVar(playerid,"InWork");
	DeletePVar(playerid,"MeatCheck");
	DeletePVar(playerid,"BadMeatDel");
	DeletePVar(playerid,"BadMeat");
	DeletePVar(playerid,"OldSkin");
	DeletePVar(playerid,"OnWork");

	killgr(playerid);
	//trasher
	if(HasTrash[playerid]) Trash_ResetPlayer(playerid);
	//end trasher
    SetPlayerName(playerid, pData[playerid][pName]);

	if(pData[playerid][pSekolahSim] == 1)
	{
		pData[playerid][pSekolahSim] = 0;
		Global[SKM] = 0;
	}
    if(pData[playerid][pRobb] == 1)
	{
		pData[playerid][pRobb] = 0;
		Global[ROB] = 0;
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
        RemovePlayerFromVehicle(playerid);
    }
	//UpdateWeapons(playerid);
	g_MysqlRaceCheck[playerid]++;

	if(pData[playerid][IsLoggedIn] == true)
	{
		/*if(IsAtEvent[playerid] == 0)
		{
			UpdatePlayerData(playerid);
		}*/
		UpdatePlayerData(playerid);
		SaveLegacySystem(playerid);
		RemovePlayerVehicle(playerid);
		for(new v; v < MAX_PLAYER_VEHICLE; ++v)
		{
		    for(new vt = 0; vt < 4; vt++)
		 	{
		 	 	DestroyObject(vtData[v][vt][vtoy_model]);
			}
		}
		Report_Clear(playerid);
		Ask_Clear(playerid);
		Player_ResetMining(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		KillTazerTimer(playerid);
		if(IsAtEvent[playerid] == 1)
		{
			if(GetPlayerTeam(playerid) == 1)
			{
				if(EventStarted == 1)
				{
					RedTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 2)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d00 per orang", EventPrize);
							SetPlayerPos(ii, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
							pData[playerid][pHospital] = 0;
							ResetPlayerWeapons(ii);
							SetPlayerColor(ii, COLOR_WHITE);
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 1)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
							pData[playerid][pHospital] = 0;
							ResetPlayerWeapons(ii);
							SetPlayerColor(ii, COLOR_WHITE);
							ClearAnimations(ii);
							RedTeam = 0;
						}
					}
				}
			}
			if(GetPlayerTeam(playerid) == 2)
			{
				if(EventStarted == 1)
				{
					BlueTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 1)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d00 per orang", EventPrize);
							SetPlayerPos(ii, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
							pData[playerid][pHospital] = 0;
							ResetPlayerWeapons(ii);
							SetPlayerColor(ii, COLOR_WHITE);
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 2)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
							pData[playerid][pHospital] = 0;
							ResetPlayerWeapons(ii);
							SetPlayerColor(ii, COLOR_WHITE);
							ClearAnimations(ii);
							BlueTeam = 0;
						}
					}
				}
			}
			SetPlayerTeam(playerid, 0);
			IsAtEvent[playerid] = 0;
			pData[playerid][pInjured] = 0;
			pData[playerid][pSpawned] = 1;
		}
	}
	if(IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

	if(IsValidDynamicObject(pData[playerid][pFlare]))
            DestroyDynamicObject(pData[playerid][pFlare]);

    pData[playerid][pAdoActive] = false;

	if(cache_is_valid(pData[playerid][Cache_ID]))
	{
		cache_delete(pData[playerid][Cache_ID]);
		pData[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
	}

	if (pData[playerid][LoginTimer])
	{
		KillTimer(pData[playerid][LoginTimer]);
		pData[playerid][LoginTimer] = 0;
	}

	pData[playerid][IsLoggedIn] = false;

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	//hauling tr
	for(new i; i <= 9; i++) // 9 = Total Dialog , Jadi kita mau tau kalau Player Ini Apakah Ambil Dialog dari 3 tersebut apa ga !
	{
		if(DialogSaya[playerid][i] == true) // Cari apakah dia punya salah satu diantara 10 dialog tersebut
		{
		    DialogSaya[playerid][i] = false; // Ubah Jadi Dia ga punya dialog lagi Kalau Udah Disconnect (Bukan dia lagi pemilik)
		    DialogHauling[i] = false; // Jadi ga ada yang punya nih dialog
		    DestroyVehicle(TrailerHauling[playerid]);
		}
	}
	new reasontext[526];
	switch(reason)
	{
	    case 1: reasontext = "Timeout/Crash";
	    case 0: reasontext = "Quit";
	    case 2: reasontext = "Kick/Ban";
	}
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessageEx(ii, COLOR_BAN, "<!> One of the players near you has left the server");
				}
			}
		}
	}
    format(string, sizeof string, "Player ID %d",playerid);
    new DCC_Embed:apalah;
 	format(str,sizeof(str),"%s",name);
 	format(stra,sizeof(stra),"%s",reasontext);
 	format(stro,sizeof(stro),"%d/%d",online,GetMaxPlayers());
	apalah = DCC_CreateEmbed("LEGACY PRIDE ROLEPLAY","Player Disconnect","","",0xff0000,"Join us @gta-legacypride.id","","","");
	DCC_AddEmbedField(apalah, str, string, true);
	DCC_AddEmbedField(apalah, "Reason", stra, true);
	DCC_AddEmbedField(apalah, "Current Player", stro, true);
	DCC_SendChannelEmbedMessage(g_discord_server, apalah);

	Player_Fire_Enabled[playerid] = false;
	Player_Key_Sprint_Time[playerid] = 0;
	return 1;
}


public OnPlayerSpawn(playerid)
{
	if(PlayerPBing[playerid] == true)
	{
	    new RandomSpawn = random(sizeof(PBSpawns));
	    new RandomSkins = random(sizeof(PBSkins));
	    SetPlayerSkin(playerid,PBSkins[RandomSkins]);
		SetPlayerPos(playerid,PBSpawns[RandomSpawn][0],PBSpawns[RandomSpawn][1],PBSpawns[RandomSpawn][2]);
		SetPlayerFacingAngle(playerid,PBSpawns[RandomSpawn][3]);
		SetPlayerHealth(playerid,100.0);
		SetPlayerArmour(playerid,50.0);
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,PBGunID,99999);
	}
	LoadLegacySystem(playerid);

	SetPlayerFightingStyle(playerid, pData[playerid][pFightStyle]);
	StopAudioStreamForPlayer(playerid);
	SetPlayerArmour(playerid, pData[playerid][pArmour]);
	SetPlayerInterior(playerid, pData[playerid][pInt]);
	SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
    SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
    SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 0);
	SetPlayerSpawn(playerid);
	LoadAnims(playerid);

	SetPlayerSkillLevel(playerid, WEAPON_COLT45, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
	SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPON_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPON_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
	SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
	SetPlayerSkillLevel(playerid, WEAPON_RIFLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);
	//butcher
	if(GetPVarInt(playerid,"InWork"))
	{
	    if(IsValidDynamicObject(playerobject[playerid][0])) DestroyDynamicObject(playerobject[playerid][0]);
	    else if(IsValidDynamicObject(playerobject[playerid][1])) DestroyDynamicObject(playerobject[playerid][1]);
	    DeletePVar(playerid,"InWork");
	}
	return 1;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pGender] == 0)
		{
			TogglePlayerControllable(playerid,0);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			//SetPlayerPos(playerid, 1716.1129, -1880.0715, -10.0);
			InterpolateCameraPos(playerid, 1964.020629, -1746.168457, 21.459442, 1970.416503, -1819.768920, 22.540792, 8000);
			InterpolateCameraLookAt(playerid, 1960.333129, -1749.514892, 21.008031, 1966.392456, -1816.848754, 22.012056, 8000);
			SetPlayerVirtualWorld(playerid, 0);
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "\n\t{FFFFFF}MINIMAL UMUR "AQUA"18 {FFFFFF}TAHUN\n\n{FFFFFF}CONTOH:\n"AQUA"(TANGGAL/BULAN/TAHUN)\n{00FFFF}15"WHITE_E"/{00FFFF}03"WHITE_E"/{00FFFF}2001", "Enter", "Batal");
		}
		else
		{
			if(pData[playerid][pHBEMode] == 1) //simple
			{
				PlayerTextDrawShow(playerid, DIGIHUNGER[playerid]);
				PlayerTextDrawShow(playerid, DIGIENERGY[playerid]);
				for(new txd; txd < 3; txd++)
				{
					TextDrawShowForPlayer(playerid, JGRP[txd]);
				}
			}
			if(pData[playerid][pHBEMode] == 2) //modern
			{
				TextDrawHideForPlayer(playerid, TextFare);
				TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
				//-----------------
				PlayerTextDrawShow(playerid, DGFood[playerid]);
				PlayerTextDrawShow(playerid, DGEnergy[playerid]);
				for(new txd; txd < 6; txd++)
				{
					TextDrawShowForPlayer(playerid, LaparHaus[txd]);
				}
			}
			SetPlayerSkin(playerid, pData[playerid][pSkin]);
			if(pData[playerid][pOnDuty] >= 1)
			{
				SetPlayerSkin(playerid, pData[playerid][pFacSkin]);
				SetFactionColor(playerid);
			}
			if(pData[playerid][pAdminDuty] > 0)
			{
				SetPlayerColor(playerid, COLOR_RED);
			}
			SetTimerEx("SpawnTimer", 6000, false, "i", playerid);
		}
	}
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == SpawnMale)
    {
		if(response)
		{
			pData[playerid][pSkin] = modelid;
			SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1642.8126, -2333.4019, 13.5469, 359.7415, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
		}
    }
	if(listid == SpawnFemale)
    {
		if(response)
		{
			pData[playerid][pSkin] = modelid;
			SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1642.8126, -2333.4019, 13.5469, 359.7415, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
		}
    }
	//Locker Faction Skin
	if(listid == SAPDMale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SAPDFemale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SAPDWar)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SAGSMale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SAGSFemale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SAMDMale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SAMDFemale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SANEWMale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	if(listid == SANEWFemale)
    {
		if(response)
		{
			pData[playerid][pFacSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
		}
    }
	///Bisnis buy skin clothes
	if(listid == MaleSkins)
    {
		if(response)
		{
			new bizid = pData[playerid][pInBiz], price;
			price = bData[bizid][bP][0];
			pData[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			GivePlayerMoneyEx(playerid, -price);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli pakaian ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
            bData[bizid][bProd]--;
            bData[bizid][bMoney] += Server_Percent(price);
			Server_AddPercent(price);
            Bisnis_Save(bizid);
			Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
		}
		else return Servers(playerid, "Canceled buy skin");
    }
	if(listid == FemaleSkins)
    {
		if(response)
		{
			new bizid = pData[playerid][pInBiz], price;
			price = bData[bizid][bP][0];
			pData[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
			GivePlayerMoneyEx(playerid, -price);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli pakaian ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
            bData[bizid][bProd]--;
            bData[bizid][bMoney] += Server_Percent(price);
			Server_AddPercent(price);
            Bisnis_Save(bizid);
			Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
		}
		else return Servers(playerid, "Anda tidak jadi membeli skin");
    }
	if(listid == VIPMaleSkins)
    {
		if(response)
		{
			pData[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
			Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
		}
		else return Servers(playerid, " Anda tidak jadi membeli skin");
    }
	if(listid == VIPFemaleSkins)
    {
		if(response)
		{
			pData[playerid][pSkin] = modelid;
			SetPlayerSkin(playerid, modelid);
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d.", ReturnName(playerid), modelid);
			Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
		}
		else return Servers(playerid, "Canceled buy skin");
    }
    if(listid == vtoylist)
	{
		if(response)
		{
			new x = GetPlayerVehicleID(playerid);
			foreach(new i: PVehicles)
			if(x == pvData[i][cVeh])
			{
				new vehid = pvData[i][cVeh];
				vtData[vehid][pvData[vehid][vtoySelected]][vtoy_modelid] = modelid;
				if(pvData[vehid][PurchasedvToy] == false)
				{
					MySQL_CreateVehicleToy(i);
				}
				vtData[vehid][pvData[vehid][vtoySelected]][vtoy_model] = CreateDynamicObject(vtData[vehid][pvData[vehid][vtoySelected]][vtoy_modelid], 0.0, 0.0, -14.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(vtData[vehid][pvData[vehid][vtoySelected]][vtoy_model], vehid, vtData[vehid][pvData[vehid][vtoySelected]][vtoy_x], vtData[vehid][pvData[vehid][vtoySelected]][vtoy_y], vtData[vehid][pvData[vehid][vtoySelected]][vtoy_z], vtData[vehid][pvData[vehid][vtoySelected]][vtoy_rx], vtData[vehid][pvData[vehid][vtoySelected]][vtoy_ry], vtData[vehid][pvData[vehid][vtoySelected]][vtoy_rz]);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memasang toys untuk vehicleid(%d) object ID %d", ReturnName(playerid), vehid, modelid);
				ShowPlayerDialog(playerid, VTOY_ACCEPT, DIALOG_STYLE_MSGBOX, "Vehicle Toys", "Do You Want To Save it?", "Yes", "Cancel");
			}
		}
		else return Servers(playerid, "Canceled buy toys");
	}
	if(listid == toyslist)
	{
		if(response)
		{
			new bizid = pData[playerid][pInBiz], price;
			price = bData[bizid][bP][1];

			GivePlayerMoneyEx(playerid, -price);
			if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
			pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
			new finstring[750];
			strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
			strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");

            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli object ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
            bData[bizid][bProd]--;
            bData[bizid][bMoney] += Server_Percent(price);
			Server_AddPercent(price);
            Bisnis_Save(bizid);
		}
		else return Servers(playerid, "Canceled buy toys");
	}
	if(listid == viptoyslist)
	{
		if(response)
		{
			if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
			pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
			new finstring[750];
			strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
			strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");

            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengambil object ID %d dilocker.", ReturnName(playerid), modelid);
		}
		else return Servers(playerid, "Canceled toys");
	}
	if(listid == rentjoblist)
	{
		if(response)
		{
			if(modelid == 414)
			{
				//new modelid = 414;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 455)
			{
				//new modelid = 455;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 456)
			{
			//new modelid = 456;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 498)
			{
				//new modelid = 498;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 499)
			{
				//new modelid = 499;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 609)
			{
				//new modelid = 609;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 478)
			{
				//new modelid = 478;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 422)
			{
				//new modelid = 422;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 543)
			{
				//new modelid = 543;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 554)
			{
				//new modelid = 554;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 525)
			{
				//new modelid = 525;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 438)
			{
				//new modelid = 438;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
			if(modelid == 420)
			{
				//new modelid = 420;
				new tstr[128];
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan menyewa kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"$500 / one days", GetVehicleModelName(modelid));
				ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARSCONFIRM, DIALOG_STYLE_MSGBOX, "Rental Vehicles", tstr, "Rental", "Batal");
			}
		}
		else return Servers(playerid, "Canceled buy vehicle");
	}
	if(listid == sportcar)
	{
		if(response)
		{
			if(modelid == 400)
			{
				//new modelid = 414;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 402)
			{
				//new modelid = 455;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 415)
			{
				//new modelid = 498;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 421)
			{
				//new modelid = 499;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 429)
			{
				//new modelid = 609;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 436)
			{
				//new modelid = 478;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 466)
			{
				//new modelid = 543;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 533)
			{
				//new modelid = 414;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 541)
			{
				//new modelid = 455;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 543)
			{
			//new modelid = 456;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 579)
			{
				//new modelid = 498;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 602)
			{
				//new modelid = 499;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 405)
			{
				//new modelid = 609;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 603)
			{
				//new modelid = 478;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 589)
			{
				//new modelid = 422;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 587)
			{
				//new modelid = 543;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 566)
			{
				//new modelid = 554;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 562)
			{
				//new modelid = 525;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 560)
			{
				//new modelid = 438;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 559)
			{
				//new modelid = 420;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 558)
			{
				//new modelid = 609;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 551)
			{
				//new modelid = 478;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 540)
			{
				//new modelid = 422;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 534)
			{
				//new modelid = 543;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 527)
			{
				//new modelid = 554;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 507)
			{
				//new modelid = 525;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 411)
			{
				//new modelid = 420;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
			if(modelid == 477)
			{
				//new modelid = 477;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
   			if(modelid == 522)
			{
				//new modelid = 477;
				new tstr[128], price = GetVipVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d gold", GetVehicleModelName(modelid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYPVCP_VIPCONFIRM, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
		}
		else return Servers(playerid, "Canceled Buy Vehicle");
	}
	if(listid == boatlist)
	{
		if(response)
		{
			if(modelid == 446)
			{
				new tstr[128], price = GetVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
				ShowPlayerDialog(playerid, DIALOG_BUYBOAT_CONFIRM, DIALOG_STYLE_MSGBOX, "Boat", tstr, "Buy", "Cancel");
			}
			if(modelid == 453)
			{
				new tstr[128], price = GetVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
				ShowPlayerDialog(playerid, DIALOG_BUYBOAT_CONFIRM, DIALOG_STYLE_MSGBOX, "Boat", tstr, "Buy", "Cancel");
			}
			if(modelid == 472)
			{
				new tstr[128], price = GetVehicleCost(modelid);
				pData[playerid][pBuyPvModel] = modelid;
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleModelName(modelid), FormatMoney(price));
				ShowPlayerDialog(playerid, DIALOG_BUYBOAT_CONFIRM, DIALOG_STYLE_MSGBOX, "Boat", tstr, "Buy", "Cancel");
			}
		}
		else return Servers(playerid, "Canceled Buy Boat");
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	InterpolateCameraPos(playerid, 2209.850585, -1115.027709, 37.585510, 2019.370605, -1123.279907, 45.939300, 50000);
	InterpolateCameraLookAt(playerid, 2205.017089, -1116.304321, 37.493427, 2017.365600, -1127.638549, 44.531455, 50000);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
 	new mstr[128];
 	format(mstr, sizeof(mstr), "Masukkan password anda jika ingin bermain!");
	ShowPlayerDialog(playerid, DIALOG_NGENTOD, DIALOG_STYLE_MSGBOX, "Eror", mstr, "Close", "");
	KickEx(playerid);
	return 1;
}
//end
public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		new reasontext[526];
		switch(reason)
		{
	        case 0: reasontext = "Fist";
	        case 1: reasontext = "Brass Knuckles";
	        case 2: reasontext = "Golf Club";
	        case 3: reasontext = "Nite Stick";
	        case 4: reasontext = "Knife";
	        case 5: reasontext = "Basebal Bat";
	        case 6: reasontext = "Shovel";
	        case 7: reasontext = "Pool Cue";
	        case 8: reasontext = "Katana";
	        case 9: reasontext = "Chain Shaw";
	        case 14: reasontext = "Cane";
	        case 18: reasontext = "Molotov";
	        case 22..24: reasontext = "Pistol";
	        case 25..27: reasontext = "Shotgan";
	        case 28..34: reasontext = "Laras long";
		    case 49: reasontext = "Rammed by Car";
		    case 50: reasontext = "Helicopter blades";
		    case 51: reasontext = "Explosion";
		    case 53: reasontext = "Drowned";
		    case 54: reasontext = "Splat";
		    case 255: reasontext = "Suicide";
		}
		new h, m, s;
		new day, month, year;
	    gettime(h, m, s);
	    getdate(year,month,day);

        new string[128];
        format(string, sizeof string, "```%02d.%02d.%d - %02d:%02d:%02d```\n```\n%s [ID: %d] killed %s [ID: %d] (%s)\n```",day, month, year, h, m, s, pData[killerid][pName], killerid, pData[playerid][pName], playerid, reasontext);
        DCC_SendChannelMessage(g_Discord_Kill, string);
	}
    else
	{
	new reasontext[526];
	switch(reason)
	{
        case 0: reasontext = "Fist";
        case 1: reasontext = "Brass Knuckles";
        case 2: reasontext = "Golf Club";
        case 3: reasontext = "Nite Stick";
        case 4: reasontext = "Knife";
        case 5: reasontext = "Basebal Bat";
        case 6: reasontext = "Shovel";
        case 7: reasontext = "Pool Cue";
        case 8: reasontext = "Katana";
        case 9: reasontext = "Chain Shaw";
        case 14: reasontext = "Cane";
        case 18: reasontext = "Molotov";
        case 22..24: reasontext = "Pistol";
        case 25..27: reasontext = "Shotgan";
        case 28..34: reasontext = "Laras long";
	    case 49: reasontext = "Rammed by Car";
	    case 50: reasontext = "Helicopter blades";
	    case 51: reasontext = "Explosion";
	    case 53: reasontext = "Drowned";
	    case 54: reasontext = "Splat";
	    case 255: reasontext = "Suicide";
	}
    new h, m, s;
    new day, month, year;
    gettime(h, m, s);
    getdate(year,month,day);
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);

    new string[128];
    format(string, sizeof string, "```%02d.%02d.%d - %02d:%02d:%02d```\n```\n%s [ID: %d] death(%s)\n```",day, month, year, h, m, s, name, playerid, reasontext);
    DCC_SendChannelMessage(g_Discord_Kill, string);
	}

	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	pData[playerid][pSpawned] = 0;
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	Player_ResetMining(playerid);
	Player_ResetHarvest(playerid);

	pData[playerid][CarryProduct] = 0;

	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;

	pData[playerid][pMechDuty] = 0;
	pData[playerid][pTaxiDuty] = 0;
	pData[playerid][pMission] = -1;
	pData[playerid][pDealerMission] = -1;
	SedangHauling[playerid] = 0;
	//RecogioChatarra[playerid] = 0;

	pData[playerid][pSideJob] = 0;
	pData[playerid][pJobTime] = 0;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	UpdatePlayerData(playerid);
	foreach(new ii : Player)
    {
        if(pData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }
    if(TakingPs[playerid] == 1 || TakingPs[playerid] == 0) {
		DestroyDynamicCP(cp[playerid]);
		TakingPs[playerid] = 2;
	}
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 22, weaponname[18], string[340];

            GetWeaponName(weaponid, weaponname, sizeof(weaponname));

            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;

            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);

            Servers(playerid, "You have successfully adjusted the position of your %s.", weaponname);

            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", pData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	else
	{
		if(response == 1)
		{
			GameTextForPlayer(playerid, "~g~~h~Toy Position Updated~y~!", 4000, 5);

			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;

			MySQL_SavePlayerToys(playerid);
		}
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(pData[playerid][EditingVending] != -1 && Iter_Contains(Vending, pData[playerid][EditingVending]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new venid = pData[playerid][EditingVending];
	        VendingData[venid][VendingPosX] = x;
	        VendingData[venid][VendingPosY] = y;
	        VendingData[venid][VendingPosZ] = z;
	        VendingData[venid][VendingPosRX] = rx;
	        VendingData[venid][VendingPosRY] = ry;
	        VendingData[venid][VendingPosRZ] = rz;

	        SetDynamicObjectPos(objectid, VendingData[venid][VendingPosX], VendingData[venid][VendingPosY], VendingData[venid][VendingPosZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][VendingPosRX], VendingData[venid][VendingPosRY], VendingData[venid][VendingPosRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][VendingLabel], E_STREAMER_X, VendingData[venid][VendingPosX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][VendingLabel], E_STREAMER_Y, VendingData[venid][VendingPosY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][VendingLabel], E_STREAMER_Z, VendingData[venid][VendingPosZ] + 0.3);

		    VendingSave(venid);
	        pData[playerid][EditingVending] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new venid = pData[playerid][EditingVending];
	        SetDynamicObjectPos(objectid, VendingData[venid][VendingPosX], VendingData[venid][VendingPosY], VendingData[venid][VendingPosZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][VendingPosRX], VendingData[venid][VendingPosRY], VendingData[venid][VendingPosRZ]);
	    	pData[playerid][EditingVending] = -1;
	    }
	}
	if(pData[playerid][EditingVtoys] != -1)
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	    	new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);
	        new vehid = pvData[vehicleid][cVeh];
	        new idxs = pvData[vehid][vtoySelected];
	        vtData[vehid][idxs][vtoy_x] = x;
	        vtData[vehid][idxs][vtoy_y] = y;
	        vtData[vehid][idxs][vtoy_z] = z;
	        vtData[vehid][idxs][vtoy_rx] = rx;
	        vtData[vehid][idxs][vtoy_ry] = ry;
	        vtData[vehid][idxs][vtoy_rz] = rz;

	        SetDynamicObjectPos(objectid, vtData[vehid][idxs][vtoy_x], vtData[vehid][idxs][vtoy_y], vtData[vehid][idxs][vtoy_z]);
	        SetDynamicObjectRot(objectid, vtData[vehid][idxs][vtoy_rx], vtData[vehid][idxs][vtoy_ry], vtData[vehid][idxs][vtoy_rz]);

		    MySQL_SaveVehicleToys(vehicleid);
	        pData[playerid][EditingVtoys] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new vehid = pData[playerid][EditingVtoys];
	        new idxs = pvData[vehid][vtoySelected];
	        SetDynamicObjectPos(objectid, vtData[vehid][idxs][vtoy_x], vtData[vehid][idxs][vtoy_y], vtData[vehid][idxs][vtoy_z]);
	        SetDynamicObjectRot(objectid, vtData[vehid][idxs][vtoy_rx], vtData[vehid][idxs][vtoy_ry], vtData[vehid][idxs][vtoy_rz]);
	    	pData[playerid][EditingVtoys] = -1;
	    }
	}
	//graf
	if(response == EDIT_RESPONSE_FINAL )
	{
		if(GetPVarInt(playerid, "GraffitiCreating") == 1 )
		{
			new id = nGraffiti();
	        gInfo[id][Xpos] = x;
	        gInfo[id][Ypos] = y;
	        gInfo[id][Zpos] = z;
	        gInfo[id][XYpos] = rx;
	        gInfo[id][YYpos] = ry;
	        gInfo[id][ZYpos] = rz;

	        SetDynamicObjectPos(objectid, gInfo[id][Xpos], gInfo[id][Ypos], gInfo[id][Zpos]);
	        SetDynamicObjectRot(objectid, gInfo[id][XYpos], gInfo[id][YYpos], gInfo[id][ZYpos]);
		}
	}
	if( response == EDIT_RESPONSE_CANCEL )
	{
		if(GetPVarInt(playerid, "GraffitiCreating") == 1 )
		{
			DestroyDynamicObject( POBJECT[playerid] );
			SendClientMessage( playerid,0xFF6800FF,"Creation of Graffiti Canceled" ); // <---
			DeletePVar( playerid,"GraffitiCreating" );
		}
	}
    new String[10000];
    new idx = gymEditID[playerid];
	if(response == EDIT_RESPONSE_UPDATE)
	{
	    SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}
	else if(response == EDIT_RESPONSE_CANCEL)
	{
	    if(gymEditID[playerid] != 0)
	    {
		    SetDynamicObjectPos(objectid, gymObjectPos[playerid][0], gymObjectPos[playerid][1], gymObjectPos[playerid][2]);
			SetDynamicObjectRot(objectid, gymObjectRot[playerid][0], gymObjectRot[playerid][1], gymObjectRot[playerid][2]);
			gymObjectPos[playerid][0] = 0; gymObjectPos[playerid][1] = 0; gymObjectPos[playerid][2] = 0;
			gymObjectRot[playerid][0] = 0; gymObjectRot[playerid][1] = 0; gymObjectRot[playerid][2] = 0;
			gymEdit[playerid] = 0;
			gymEditID[playerid] = 0;
		}
	}
	else if(response == EDIT_RESPONSE_FINAL)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
		if(gymEdit[playerid] == 1)
		{
		    GYMInfo[idx][GYMOBJPos][0] = x;
	        GYMInfo[idx][GYMOBJPos][1] = y;
	        GYMInfo[idx][GYMOBJPos][2] = z;
	        GYMInfo[idx][GYMOBJPos][3] = rx;
	        GYMInfo[idx][GYMOBJPos][4] = ry;
	        GYMInfo[idx][GYMOBJPos][5] = rz;
	        GYMInfo[idx][GYMvw] = GetPlayerVirtualWorld(playerid);
        	GYMInfo[idx][GYMint] = GetPlayerInterior(playerid);
	        DestroyDynamic3DTextLabel(GYMInfo[idx][GYMOBJText]);
   			format(String, 128, "[ID:%d]\n{00FF00}Available\n%d/1000", idx, GYMInfo[idx][GYMOBJCondition]);
			GYMInfo[idx][GYMOBJText] = CreateDynamic3DTextLabel(String, COLOR_YELLOW, GYMInfo[idx][GYMOBJPos][0], GYMInfo[idx][GYMOBJPos][1], GYMInfo[idx][GYMOBJPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GYMInfo[idx][GYMvw], GYMInfo[idx][GYMint], -1, 10.0);
			SaveGYMObject();
		    gymEdit[playerid] = 0;
		    gymEditID[playerid] = 0;
		}
	}
    idx = oEditID[playerid];
	if(response == EDIT_RESPONSE_UPDATE)
	{
	    SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}
	else if(response == EDIT_RESPONSE_CANCEL)
	{
	    if(oEditID[playerid] != 0)
	    {
		    SetDynamicObjectPos(objectid, oPos[playerid][0], oPos[playerid][1], oPos[playerid][2]);
			SetDynamicObjectRot(objectid, oRot[playerid][0], oRot[playerid][1], oRot[playerid][2]);
			oPos[playerid][0] = 0; oPos[playerid][1] = 0; oPos[playerid][2] = 0;
			oRot[playerid][0] = 0; oRot[playerid][1] = 0; oRot[playerid][2] = 0;
			format(String, sizeof(String), " Anda membatalkan Edit Object ID %d.", idx);
			SendClientMessage(playerid, COLOR_WHITE, String);
			oEdit[playerid] = 0;
			oEditID[playerid] = 0;
		}
	}
	else if(response == EDIT_RESPONSE_FINAL)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
		if(oEdit[playerid] == 1)
		{
		    ObjectInfo[idx][oX] = x;
			ObjectInfo[idx][oY] = y;
			ObjectInfo[idx][oZ] = z;
			ObjectInfo[idx][oRX] = rx;
			ObjectInfo[idx][oRY] = ry;
			ObjectInfo[idx][oRZ] = rz;
			//ObjectInfo[idx][oText] = CreateDynamic3DTextLabel(String, COLOR_WHITE, ObjectInfo[idx][oX], ObjectInfo[idx][oY], ObjectInfo[idx][oZ], 10);
		    oEdit[playerid] = 0;
		    oEditID[playerid] = 0;
		    format(String, sizeof(String), " Anda telah menyelesaikan Edit Posisi Object ID %d.", idx);
		    SendClientMessage(playerid, COLOR_WHITE, String);
			SaveObj();
		}
	}
	//--
	if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        TreeData[etid][treeX] = x;
	        TreeData[etid][treeY] = y;
	        TreeData[etid][treeZ] = z;
	        TreeData[etid][treeRX] = rx;
	        TreeData[etid][treeRY] = ry;
	        TreeData[etid][treeRZ] = rz;

	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_X, TreeData[etid][treeX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Y, TreeData[etid][treeY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Z, TreeData[etid][treeZ] + 1.5);

		    Tree_Save(etid);
	        pData[playerid][EditingTreeID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
	        pData[playerid][EditingTreeID] = -1;
	    }
	}
    if(pData[playerid][EditingBerryID] != -1 && Iter_Contains(Berrys, pData[playerid][EditingBerryID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingBerryID];
	        BerryData[etid][berryX] = x;
	        BerryData[etid][berryY] = y;
	        BerryData[etid][berryZ] = z;
	        BerryData[etid][berryRX] = rx;
	        BerryData[etid][berryRY] = ry;
	        BerryData[etid][berryRZ] = rz;

	        SetDynamicObjectPos(objectid, BerryData[etid][berryX], BerryData[etid][berryY], BerryData[etid][berryZ]);
	        SetDynamicObjectRot(objectid, BerryData[etid][berryRX], BerryData[etid][berryRY], BerryData[etid][berryRZ]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_X, BerryData[etid][berryX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_Y, BerryData[etid][berryY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BerryData[etid][berryLabel], E_STREAMER_Z, BerryData[etid][berryZ] + 1.5);

		    Berry_Save(etid);
	        pData[playerid][EditingBerryID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingBerryID];
	        SetDynamicObjectPos(objectid, BerryData[etid][berryX], BerryData[etid][berryY], BerryData[etid][berryZ]);
	        SetDynamicObjectRot(objectid, BerryData[etid][berryRX], BerryData[etid][berryRY], BerryData[etid][berryRZ]);
	        pData[playerid][EditingBerryID] = -1;
	    }
	}
	if(pData[playerid][EditingOreID] != -1 && Iter_Contains(Ores, pData[playerid][EditingOreID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        OreData[etid][oreX] = x;
	        OreData[etid][oreY] = y;
	        OreData[etid][oreZ] = z;
	        OreData[etid][oreRX] = rx;
	        OreData[etid][oreRY] = ry;
	        OreData[etid][oreRZ] = rz;

	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_X, OreData[etid][oreX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Y, OreData[etid][oreY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Z, OreData[etid][oreZ] + 1.5);

		    Ore_Save(etid);
	        pData[playerid][EditingOreID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);
	        pData[playerid][EditingOreID] = -1;
	    }
	}
	if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ] + 0.3);

		    Atm_Save(etid);
	        pData[playerid][EditingATMID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        pData[playerid][EditingATMID] = -1;
	    }
	}
	if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
	{
		new id = pData[playerid][gEditID];
		if(response == EDIT_RESPONSE_UPDATE)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
			SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
			gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
			gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
			Servers(playerid, " You have canceled editing gate ID %d.", id);
			Gate_Save(id);
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			if(pData[playerid][gEdit] == 1)
			{
				gData[id][gCX] = x;
				gData[id][gCY] = y;
				gData[id][gCZ] = z;
				gData[id][gCRX] = rx;
				gData[id][gCRY] = ry;
				gData[id][gCRZ] = rz;
				if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
				new str[64];
				format(str, sizeof(str), "Gate ID: %d", id);
				gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);

				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's closing position.", id);
				gData[id][gStatus] = 0;
				Gate_Save(id);
			}
			else if(pData[playerid][gEdit] == 2)
			{
				gData[id][gOX] = x;
				gData[id][gOY] = y;
				gData[id][gOZ] = z;
				gData[id][gORX] = rx;
				gData[id][gORY] = ry;
				gData[id][gORZ] = rz;

				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's opening position.", id);

				gData[id][gStatus] = 1;
				Gate_Save(id);
			}
		}
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	//pilot
	if(IsPlayerInDynamicCP(playerid, cp[playerid]))
	{
	    if(TakingPs[playerid] == 1)
	    {
     		rands2 = random(sizeof(RandomCPs));
	        while (rands2 == rands)
	        {
	            rands2 = random(sizeof(RandomCPs));
			}
	    	SendClientMessage(playerid, 0x00FF24AA, "You took passengers and now are looking to leave, when ready.");
	    	DestroyDynamicCP(cp[playerid]);
 			rands = random(sizeof(RandomCPs));
 			TakingPs[playerid] = 0;
	 		cp[playerid] = CreateDynamicCP(RandomCPs[rands2][0],RandomCPs[rands2][1],RandomCPs[rands2][2], 20, -1, playerid, -1, 6000);
	 		return 1;
		}
		if(TakingPs[playerid] == 0)
		{
		    new wst[180];
			new pilotN[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, pilotN, sizeof(pilotN));
		    format(wst, sizeof(wst), "Officer looking at you said: Well work MR.%s you have done your job honestly then he fetches something from his pocket and handes to you.", pilotN);
		    SendClientMessage(playerid, 0x26CF12AA, "You completed your passengers' trip (Which you must have to do), then a staff officer approached you...");
		    SendClientMessage(playerid, 0x26CF12AA, wst);
		    SendClientMessage(playerid, 0x26CF12AA, "You then hurried and opened you hand, it was filled with bucks i.e cash. You were payed. If you again need the work type /pwork");
			GivePlayerMoney(playerid, WorkBucks);
			DestroyDynamicCP(cp[playerid]);
			TakingPs[playerid] = 2;
			return 1;
		}
	}
	//trash
	else if(checkpointid == TrashCP[playerid])
	{
	    if(!HasTrash[playerid]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not carrying a trash bag.");
	    new vehicleid = GetPVarInt(playerid, "LastVehicleID");
	    if(LoadedTrash[vehicleid] >= TRASH_LIMIT) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}This vehicle is full, you can't load any more trash.");
	    LoadedTrash[vehicleid]++;
		ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0);
		SendClientMessage(playerid, COLOR_JOB, "TRASHMASTER: {FFFFFF}You've collected a trash bag.");

		if(TRASH_LIMIT - LoadedTrash[vehicleid] > 0)
		{
			new string[96];
			format(string, sizeof(string), "TRASHMASTER: {FFFFFF}You can load {F39C12}%d {FFFFFF}more trash bags to this vehicle.", TRASH_LIMIT - LoadedTrash[vehicleid]);
			SendClientMessage(playerid, COLOR_JOB, string);
		}

		new driver = GetVehicleDriver(vehicleid);
		if(IsPlayerConnected(driver)) Trash_ShowCapacity(driver);
		Trash_ResetPlayer(playerid);
		return 1;
	}

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		for(new i; i < sizeof(FactoryData); i++)
		{
		    if(checkpointid == FactoryData[i][FactoryCP])
		    {
		        new string[128], vehicleid = GetPlayerVehicleID(playerid), cash = LoadedTrash[vehicleid] * TRASH_BAG_VALUE;
		        format(string, sizeof(string), "TRASHMASTER: {FFFFFF}Sold {F39C12}%d {FFFFFF}bags of trash and earned {2ECC71}$%d.", LoadedTrash[vehicleid], cash);
		        SendClientMessage(playerid, COLOR_JOB, string);
		        GivePlayerMoneyEx(playerid, cash);
		        FactoryData[i][FactoryCurrent] += LoadedTrash[vehicleid];
		        LoadedTrash[vehicleid] = 0;
                Trash_ShowCapacity(playerid);
                format(string, sizeof(string), "Recycling Factory - %s\n\n{FFFFFF}Current Trash Bags: {F39C12}%d\n{FFFFFF}Bring trash here to earn money!", FactoryData[i][FactoryName], FactoryData[i][FactoryCurrent]);
                UpdateDynamic3DTextLabelText(FactoryData[i][FactoryLabel], 0x2ECC71FF, string);

		        for(new x; x < sizeof(FactoryData); x++)
				{
				    if(IsValidDynamicMapIcon(FactoryIcons[playerid][x]))
				    {
				        DestroyDynamicMapIcon(FactoryIcons[playerid][x]);
				        FactoryIcons[playerid][x] = -1;
				    }
					TogglePlayerDynamicCP(playerid, FactoryData[x][FactoryCP], 0);
				}

		        break;
		    }
		}
	}
	//electrican
	if(checkpointid == ElectricCP[playerid])
	{
	    GetPVarInt(playerid, "LastVehicleID");

		ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0);
		SetPlayerAttachedObject(playerid, 9, 1264, 6, 0.222, 0.024, 0.128, 1.90, -90.0, 0.0, 0.5,0.5, 0.5);
		SCM(playerid, COLOR_JOB, "ELECTRICAN: {FFFFFF}Anda Mengambil Tangga.");
		DestroyDynamicCP(TrashCP[playerid]);
		return 1;
	}
	else if(checkpointid == StoremeatCP[playerid])
	{
	    if(!GetMeatBag[playerid]) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}You're not carrying a meat bag.");

	    if(StoreMeat[playerid] == 10) return Error(playerid, "You has store 10 meat!");

	    StoreMeat[playerid] += 2;
	    GetMeatBag[playerid] = false;
	    ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0);
	    RemovePlayerAttachedObject(playerid, ATTACHMENT_INDEX);
		SendClientMessage(playerid, COLOR_JOB, "BUTCHER: {FFFFFF}You've stored a meat bag.");

		Info(playerid, "You Has Stored "RED_E"%d "WHITE_E"Meat", StoreMeat[playerid]);
		return 1;
	}
	else if(checkpointid == pData[playerid][LoadingPoint])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		return 1;
	}
	else if(checkpointid == ShowRoomS)
	{
		ShowModelSelectionMenu(playerid, sportcar, "Sport Cars", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
	}
    else if(checkpointid == ShowRoomCp)
    {
        ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "Showroom", "Bikes\nCars\nUnique Cars\nJob Cars", "Select", "Cancel");
    }
	else if(checkpointid == ShowRoomCPRent)
	{
		ShowModelSelectionMenu(playerid, rentjoblist, "Rent JobsCar", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
	}
	else if(checkpointid == BoatDealer)
	{
		ShowModelSelectionMenu(playerid, boatlist, "Buy Boat", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(CheckpointLast[playerid] == 1)
	{
	    if(pData[playerid][pPacket] == 1)
	    {
		    DisablePlayerRaceCheckpoint(playerid);
		    pData[playerid][pPacket] = 0;
		    pCPPacket = INVALID_PLAYER_ID;
		    CheckpointLast[playerid] = 0;
		    taked = 0;
		    packet = 0;
		    new packet_price = Random(10000, 30000);

		    GivePlayerMoneyEx(playerid, packet_price);
		    new String[1280];
		    format(String, sizeof String, "SMUGGLER: {FFFFFF}You get $%s from delivering packet", FormatMoney(packet_price));
		 	SendClientMessage(playerid, COLOR_LOGS, String);
		 	return 1;
		}
	}
	if(pData[playerid][pTrackCar] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan kendaraan anda!");
		pData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackHouse] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan rumah anda!");
		pData[playerid][pTrackHouse] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackBisnis] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan bisnis anda!");
		pData[playerid][pTrackBisnis] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pMission] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "/buy , /gps(My Mission) , /storeproduct.");
	}
	if(pData[playerid][pHauling] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "/buy , /gps(My Hauling) , /storegas.");
	}
	if(pData[playerid][pRestock] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "/buy, /gps(My Restock Vending), /storestock.");
	}
    if(pData[playerid][pDealerMission] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "/gps(My Dealer Mission) , /storeveh.");
	}
	if(CheckpointPacket[playerid] == 1)
	{
		CheckpointPacket[playerid] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	DisablePlayerRaceCheckpoint(playerid);
	return 1;
}
public OnPlayerHackTeleport(playerid, Float:distance)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
	{
		new string[5000];
		format(string, sizeof(string), "%s have detected hack teleport.", pData[playerid][pName]);
		SendClientMessageToAll(-1, string);
		format(string, sizeof string, "```\nWarning: %s Have Detected Teleport Hack [Jarak %s]\n```",  pData[playerid][pName], distance);
		DCC_SendChannelMessage(g_discord_ban, string);
		Kick(playerid);
	}
	return 1;
}
/*CMD:arwinpackage(playerid, params[])
{
	if(PlayerInfo[playerid][pUseSorry] == 0)
	{
	    if(PlayerInfo[playerid][pLevel] < 2)
	    {
		    GivePlayerCash(playerid, 100000);
		    PlayerInfo[playerid][pLevel] = 2;
		    PlayerInfo[playerid][pAccount] += 50000;
		    PlayerInfo[playerid][pUseSorry] = 1;
		    SendClientMessage(playerid, COLOR_ARWIN, "ARWIN14: {FFFFFF}Anda telah menerima uang $1,000.00 cash dan $500.00 di ATM anda, serta level anda saya set menjadi 2");
		}
		else
		{
		    GivePlayerCash(playerid, 100000);
		    PlayerInfo[playerid][pAccount] += 50000;
		    PlayerInfo[playerid][pUseSorry] = 1;
		    SendClientMessage(playerid, COLOR_ARWIN, "ARWIN14: {FFFFFF}Anda telah menerima uang $1,000.00 cash dan $500.00 di ATM anda");
		}
		return 1;
	}
	else SendClientMessage(playerid, -1, "ERROR: Anda tidak bisa menggunakan perintah ini lebih dari satu kali");
	return 1;
}*/
CMD:openpara(playerid)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
	{
		new vid = GetPlayerVehicleID(playerid);
		if(IsToggleVehicleParachute(vid))
		{
			if(IsPlayerUsingVehPara(playerid))
			{
				StopVehicleParachuteAction(playerid);
				CallLocalFunction("OnVehicleParachuteThrown","dd",playerid,vid);
			}
			else
			{
				if(IsCollisionFlag(Item::GetCollisionFlags(vid,item_vehicle),POSITION_FLAG_AIR) && GetVehicleSpeed(vid) > 0.0)
				{
					StartVehicleParachuteAction(playerid);
					CallLocalFunction("OnVehicleParachuteOpened","dd",playerid,vid);
				}
				else
				{
					CallLocalFunction("OnVehicleParachuteOpenFail","dd",playerid,vid);
				}
			}
		}
	}
}
public OnVehicleParachuteThrown(playerid,vehicleid)
{
	InfoTD_MSG(playerid, 4000, "Vehicle Parachute ~r~thrown");
	return 1;
}

public OnVehicleParachuteOpened(playerid,vehicleid)
{
	InfoTD_MSG(playerid, 4000, "Vehicle Parachute ~g~opened");
	return 1;
}

public OnVehicleParachuteOpenFail(playerid,vehicleid)
{
	InfoTD_MSG(playerid, 4000, "Cannot use ~r~Parachute");
	return 1;
}
public OnPlayerAirbreak(playerid)
{
	new string[5000];
	SendClientMessage(playerid, -1, "You have detected airbreak teleport.");
	format(string, sizeof string, "```\nWarning: %s Detected AirBreak Teleport!\n```",  pData[playerid][pName]);
	DCC_SendChannelMessage(g_discord_ban, string);
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	if(pData[playerid][pSekolahSim] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 426)
		{
			if (IsPlayerInRangeOfPoint(playerid,  3.0, dmvpoint1))
			{
				SetPlayerCheckpoint(playerid, dmvpoint2, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint2))
			{
				SetPlayerCheckpoint(playerid, dmvpoint3, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint3))
			{
				SetPlayerCheckpoint(playerid, dmvpoint4, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint4))
			{
				SetPlayerCheckpoint(playerid, dmvpoint5, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint5))
			{
				SetPlayerCheckpoint(playerid, dmvpoint6, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint6))
			{
				SetPlayerCheckpoint(playerid, dmvpoint7, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint7))
			{
				SetPlayerCheckpoint(playerid, dmvpoint8, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint8))
			{
				SetPlayerCheckpoint(playerid, dmvpoint9, 3.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 3.0,dmvpoint9))
			{
				pData[playerid][pDriveLic] = 1;
				pData[playerid][pSekolahSim] = 0;
				Global[SKM] = 0;
				DisablePlayerCheckpoint(playerid);
				pData[playerid][pDriveLicTime] = gettime() + (60 * 86400);
				Info(playerid, "Anda telah berhasil membuat SIM");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	//robcar
    if(pData[playerid][pRobb] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		{
			{
				pData[playerid][pRobb] = 0;
				Global[ROB] = 0;
				DisablePlayerCheckpoint(playerid);

				SetPVarInt(playerid, "ROB", gettime() + 7200);
				Info(playerid, "Anda telah berhasil mengantarkan kendaraan");
				switch (random(4))
				{
				  case 0: GivePlayerMoneyEx(playerid, 2000), Info(playerid, "Uang Kamu Bertambah $20,00!");
				  case 1: GivePlayerMoneyEx(playerid, 5000), Info(playerid, "Uang Kamu Bertambah $50,00!");
				  case 2: GivePlayerMoneyEx(playerid, 10000), Info(playerid, "Uang Kamu Bertambah $100,00!");
				  case 3: GivePlayerMoneyEx(playerid, 15000), Info(playerid, "Uang Kamu Bertambah $150,00!");
				}
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	//butcher
	if(GetPVarInt(playerid,"OnWork"))
	{
		DisablePlayerCheckpoint(playerid);
	}

	if(IsPlayerInRangeOfPoint(playerid, 2.0, 2846.0537,955.7325,10.7500)) //lv
	{
 		DisablePlayerCheckpoint(playerid);
 		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.0, -1873.7448,1417.5586,7.1763)) //sf
	{
 		DisablePlayerCheckpoint(playerid);
 		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 163.5530,-54.8748,1.5781)) //ls
	{
 		DisablePlayerCheckpoint(playerid);
 		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1466.4801,1039.0343,10.0313)) //pusat
	{
 		DisablePlayerCheckpoint(playerid);
 		return 1;
	}

	if(pData[playerid][CarryingLog] != -1)
	{
		if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	if(pData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		pData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
	if(pData[playerid][pSideJob] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 574)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint1))
			{
				SetPlayerCheckpoint(playerid, sweperpoint2, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint2))
			{
				SetPlayerCheckpoint(playerid, sweperpoint3, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint3))
			{
				SetPlayerCheckpoint(playerid, sweperpoint4, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint4))
			{
				SetPlayerCheckpoint(playerid, sweperpoint5, 7.0);
			    GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint5))
			{
				SetPlayerCheckpoint(playerid, sweperpoint6, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint6))
			{
				SetPlayerCheckpoint(playerid, sweperpoint7, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint7))
			{
				SetPlayerCheckpoint(playerid, sweperpoint8, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint8))
			{
				SetPlayerCheckpoint(playerid, sweperpoint9, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint9))
			{
				SetPlayerCheckpoint(playerid, sweperpoint10, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint10))
			{
				SetPlayerCheckpoint(playerid, sweperpoint11, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint11))
			{
				SetPlayerCheckpoint(playerid, sweperpoint12, 7.0);
				GameTextForPlayer(playerid, "~g~Clean!", 1000, 3);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint12))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pSweeperTime] = 900;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Sweeper)", 4500);
				Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
		    if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus1))
			{
			    SetPlayerCheckpoint(playerid,cpbus2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus2))
			{
			    SetPlayerCheckpoint(playerid,cpbus3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus3))
			{
			    SetPlayerCheckpoint(playerid,cpbus4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus4))
			{
			    SetPlayerCheckpoint(playerid,cpbus5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus5))
			{
			    SetPlayerCheckpoint(playerid,cpbus6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus6))
			{
			    SetPlayerCheckpoint(playerid,cpbus7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus7))
			{
			    SetPlayerCheckpoint(playerid,cpbus8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus8))
			{
			    SetPlayerCheckpoint(playerid,cpbus9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus9))
			{
			    SetPlayerCheckpoint(playerid,cpbus10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus10))
			{
			    SetPlayerCheckpoint(playerid,cpbus11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus11))
			{
			    SetPlayerCheckpoint(playerid,cpbus12, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus12))
			{
			    SetPlayerCheckpoint(playerid,cpbus13, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus13))
			{
			    SetPlayerCheckpoint(playerid,cpbus14, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus14))
			{
			    SetPlayerCheckpoint(playerid,cpbus15, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus15))
			{
			    SetPlayerCheckpoint(playerid,cpbus16, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus16))
			{
			    SetPlayerCheckpoint(playerid,cpbus17, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus17))
			{
			    SetPlayerCheckpoint(playerid,cpbus18, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus18))
			{
			    SetPlayerCheckpoint(playerid,cpbus19, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus19))
			{
			    SetPlayerCheckpoint(playerid,cpbus20, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus20))
			{
			    SetPlayerCheckpoint(playerid,cpbus21, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus21))
			{
			    SetPlayerCheckpoint(playerid,cpbus22, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,cpbus22))
			{
			    SetPlayerCheckpoint(playerid,cpbus23, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,cpbus23))
			{
				SetPlayerCheckpoint(playerid,cpbus24, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,cpbus24))
			{
			    pData[playerid][pSideJob] = 0;
				pData[playerid][pBusTime] = 1200;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Bus Route A)", 9800);
				Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
		    if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp1))
			{
			    SetPlayerCheckpoint(playerid,buscp2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp2))
			{
			    SetPlayerCheckpoint(playerid,buscp3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp3))
			{
			    SetPlayerCheckpoint(playerid,buscp4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp4))
			{
			    SetPlayerCheckpoint(playerid,buscp5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp5))
			{
			    SetPlayerCheckpoint(playerid,buscp6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp6))
			{
			    SetPlayerCheckpoint(playerid,buscp7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp7))
			{
			    SetPlayerCheckpoint(playerid,buscp8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp8))
			{
			    SetPlayerCheckpoint(playerid,buscp9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp9))
			{
			    SetPlayerCheckpoint(playerid,buscp10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp10))
			{
			    SetPlayerCheckpoint(playerid,buscp11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp11))
			{
			    SetPlayerCheckpoint(playerid,buscp12, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp12))
			{
			    SetPlayerCheckpoint(playerid,buscp13, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp13))
			{
			    SetPlayerCheckpoint(playerid,buscp14, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp14))
			{
			    SetPlayerCheckpoint(playerid,buscp15, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp15))
			{
			    SetPlayerCheckpoint(playerid,buscp16, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp16))
			{
			    SetPlayerCheckpoint(playerid,buscp17, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp17))
			{
			    SetPlayerCheckpoint(playerid,buscp18, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp18))
			{
			    SetPlayerCheckpoint(playerid,buscp19, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp19))
			{
			    SetPlayerCheckpoint(playerid,buscp20, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp20))
			{
			    SetPlayerCheckpoint(playerid,buscp21, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buscp21))
			{
			    pData[playerid][pSideJob] = 0;
				pData[playerid][pBusTime] = 1200;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Bus Route B)", 13600);
				Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 3)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 530)
		{
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint1))
			{
				SetPlayerCheckpoint(playerid, forpoint2, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftTake", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengangkat Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint2))
			{
				SetPlayerCheckpoint(playerid, forpoint3, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftDown", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint3))
			{
				SetPlayerCheckpoint(playerid, forpoint4, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftTake", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengangkat Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint4))
			{
				SetPlayerCheckpoint(playerid, forpoint5, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftDown", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint5))
			{
				SetPlayerCheckpoint(playerid, forpoint6, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftTake", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengangkat Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint6))
			{
				SetPlayerCheckpoint(playerid, forpoint7, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftDown", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint7))
			{
				SetPlayerCheckpoint(playerid, forpoint8, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftTake", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengangkat Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint8))
			{
				SetPlayerCheckpoint(playerid, forpoint9, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftDown", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint9))
			{
				SetPlayerCheckpoint(playerid, forpoint10, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftTake", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mengangkat Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,forpoint10))
			{
				SetPlayerCheckpoint(playerid, forpoint11, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ForkliftDown", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Box...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid, 4.0,forpoint11))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pForkliftTime] = 900;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Forklift)", 6400);
				Info(playerid, "Sidejob(Forklift) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
				return 1;
			}
		}
	}
    if(SedangAnterPizza[playerid] == 1) // pizza
	{
        SedangAnterPizza[playerid] = 0;
	    pData[playerid][pPizzaTime] = 600;
    	AddPlayerSalary(playerid, "Sidejob(Pizza)", 7700);
    	new fmt_str[1280];
    	RemovePlayerAttachedObject(playerid,1);
    	format(fmt_str, sizeof fmt_str, "PIZZA JOB: {ffffff}Kamu mendapatkan $50.00 dari hasil mengirim pizza dan dimasukkan ke salary.");
    	SendClientMessage(playerid,COLOR_RIKO, "PIZZA JOB: {ffffff}Kamu berhasil mengirimkan pizza dan mendapat delay 10 menit.");
        SendClientMessage(playerid,COLOR_RIKO, fmt_str);
        DisablePlayerCheckpoint(playerid);
	}
    if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 578)
		{
			if (IsPlayerInRangeOfPoint(playerid, 4.0,containerpoint1))
			{
				SetPlayerCheckpoint(playerid, 2869.1934,917.6111,10.7500, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ContainerTake", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Memuat Container...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,containerpoint2))
			{
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("ContainerDown", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Container...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				pData[playerid][pSideJob] = 0;
				pData[playerid][pJobTime] = 1800;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Trucker(Container)", 8600);
				Info(playerid, "Trucker(Container) telah masuk ke pending salary anda!");
				return 1;
			}
		}
	}
	if(pData[playerid][pJob] == 9 || pData[playerid][pJob2] == 9)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 482)
		{
			if (IsPlayerInRangeOfPoint(playerid, 4.0, 2787.4229,-2417.5588,13.6338))
			{
				SetPlayerCheckpoint(playerid, 2785.6194,-2455.9802,13.6342, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("KurirDone", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meletakkan Crate...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0, 2785.6194,-2455.9802,13.6342))
			{
				SetPlayerCheckpoint(playerid, 2787.2864,-2494.1882,13.6509, 4.0);
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("KurirDone", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Memuat Crate...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				return 1;
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0,2787.2864,-2494.1882,13.6509))
			{
				TogglePlayerControllable(playerid, 0);
				pData[playerid][pActivity] = SetTimerEx("KurirDone", 400, true, "i", playerid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Memuat Crate...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				pData[playerid][pSideJob] = 0;
				pData[playerid][pJobTime] = 800;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Couriers(Jobs)", 3400);
				Info(playerid, "Couriers(Jobs) telah masuk ke pending salary anda!");
				return 1;
			}
		}
	}
	//DisablePlayerCheckpoint(playerid);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	KillTimer(pData[playerid][LimitSpeedTimer]);
	if(pData[playerid][pSekolahSim] == 1)
	{
		//new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 426)
		{
		    DisablePlayerCheckpoint(playerid);
		    Info(playerid, "Anda gagal test mengemudi karena telah keluar dari kendaraan!");
		    RemovePlayerFromVehicle(playerid);
		    Global[SKM] = 0;
		    pData[playerid][pSekolahSim] = 0;
		    SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
    KillTimer(pData[playerid][LimitSpeedTimer]);
    if(pData[playerid][pRobb] == 1)
    {
   	   DisablePlayerCheckpoint(playerid);
   	   SetPVarInt(playerid, "ROB", gettime() + 7200);
	   Info(playerid, "Anda gagal Car Stealing karena telah keluar dari kendaraan!");
	   Global[ROB] = 0;
	   pData[playerid][pRobb] = 0;
	   RemovePlayerFromVehicle(playerid);
	   SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
    }
    if (GetVehicleModel(vehicleid) == 574)
	{
	    {
	        SendClientMessageEx(playerid,COLOR_RIKO,"SIDEJOB:{FFFFFF}Kamu telah berhenti bekerja, kamu dapat bekerja Street Sweeper 10 menit lagi.");
			pData[playerid][pSideJob] = 0;
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			pData[playerid][pSweeperTime] = 600;
			DisablePlayerCheckpoint(playerid);
	    }
	}
	else if (GetVehicleModel(vehicleid) == 431)
	{
	    {
	        SendClientMessageEx(playerid,COLOR_RIKO,"SIDEJOB:{FFFFFF}Kamu telah berhenti bekerja, kamu dapat bekerja sebagai Bus Driver 10 menit lagi.");
			pData[playerid][pSideJob] = 0;
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			pData[playerid][pBusTime] = 600;
			DisablePlayerCheckpoint(playerid);
	    }
	}
	else if (GetVehicleModel(vehicleid) == 530)
	{
	    {
	        SendClientMessageEx(playerid,COLOR_RIKO,"SIDEJOB:{FFFFFF}Kamu telah berhenti bekerja, kamu dapat bekerja Forklift 10 menit lagi.");
			pData[playerid][pSideJob] = 0;
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			pData[playerid][pForkliftTime] = 600;
			DisablePlayerCheckpoint(playerid);
	    }
	}
	DisablePlayerCheckpoint(playerid);
	return 1;
}

public OnDynamicObjectMoved(objectid)
{
    new playerid = Streamer_GetIntData(STREAMER_TYPE_OBJECT,objectid,E_STREAMER_EXTRA_ID);
    if(playerid != INVALID_PLAYER_ID)
    {
		new Float:x,Float:y,Float:z;
		GetDynamicObjectPos(objectid,x,y,z);
        if(GetPVarInt(playerid,"MeatCheck"))
        {
			if(x == 944.204345)
			{
				DestroyDynamicObject(objectid);
			    GoObject(playerid);
				DeletePVar(playerid,"MeatCheck");
				GameTextForPlayer(playerid,"~g~GOOD JOB",500,5);
				SetPVarInt(playerid,"BadMeatDel", GetPVarInt(playerid,"BadMeatDel") +1);
				StoreMeat[playerid]--;
				Info(playerid, "Remaining "RED_E"%d "WHITE_E"Meat (threw out "RED_E"%d "WHITE_E"spoiled pieces)", StoreMeat[playerid],GetPVarInt(playerid,"BadMeatDel"));
			}
        }
        else
        {
            if(y == 2123.890380)
            {
			    if(StoreMeat[playerid] == -1)
				{
			    	Info(playerid, "Finish.");
			    	if(IsValidDynamicObject(playerobject[playerid][0])) DestroyDynamicObject(playerobject[playerid][0]);
					else if(IsValidDynamicObject(playerobject[playerid][1])) DestroyDynamicObject(playerobject[playerid][1]);
					SetPlayerVirtualWorld(playerid,0);
				    TogglePlayerControllable(playerid, 1);
				    SetCameraBehindPlayer(playerid);
				    DeletePVar(playerid,"MeatCheck");
					DeletePVar(playerid,"InWork");
					DeletePVar(playerid,"MeatCheck");
					DeletePVar(playerid,"BadMeatDel");
					DeletePVar(playerid,"BadMeat");
					DeletePVar(playerid,"OldSkin");
					DeletePVar(playerid,"OnWork");
			    }
			    if(GetPVarInt(playerid,"BadMeat")) GameTextForPlayer(playerid,"~r~BAD JOB",500,5);
                else GameTextForPlayer(playerid,"~g~GOOD JOB",500,5);
                DestroyDynamicObject(objectid);
			    GoObject(playerid);
			    StoreMeat[playerid]--;
			    Info(playerid, "Remaining "RED_E"%d "WHITE_E"Meat (threw out "RED_E"%d "WHITE_E"spoiled pieces)",StoreMeat[playerid] ,GetPVarInt(playerid,"BadMeatDel"));
            }
        }
    }
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(EnterDoor(playerid))
	{
		GameTextForPlayer(playerid, "~w~PRES ~r~ENTER ~w~OR ~r~F~n~~w~TO ENTER/EXIT", 4000, 4);
		return 1;
	}
	if(EnterHouse(playerid))
	{
  		GameTextForPlayer(playerid, "~w~PRES ~r~ENTER ~w~OR ~r~F~n~~w~TO ENTER/EXIT", 4000, 4);
		return 1;
	}
	if(EnterBisnis(playerid))
	{
  		GameTextForPlayer(playerid, "~w~PRES ~r~ENTER ~w~OR ~r~F~n~~w~TO ENTER/EXIT", 4000, 4);
		return 1;
	}
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    // Check if the player is not in a vehicle and pressed the conversation yes key (Y by default)
	if (!IsPlayerInAnyVehicle(playerid) && (newkeys & KEY_YES))
	{
	    // Create variables and get the players current position
	    new Float:pos[3];
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

	    // For debug
	    //printf("X = %0.2f | Y = %0.2f | Z = %0.2f", pos[0], pos[1], pos[2]);

        // Check if the player is using the button inside the elevator
	    if (pos[1] > (Y_ELEVATOR_POS - 1.8) && pos[1] < (Y_ELEVATOR_POS + 1.8) && pos[0] < (X_ELEVATOR_POS + 1.8) && pos[0] > (X_ELEVATOR_POS - 1.8))
	    {
	        // The player is using the button inside the elevator
	        // --------------------------------------------------

	        // Show the elevator dialog to the player
	        ShowElevatorDialog(playerid);
	    }
		else
		{
		    // Check if the player is using the button on one of the floors
		    if(pos[1] < (Y_ELEVATOR_POS - 1.81) && pos[1] > (Y_ELEVATOR_POS - 3.8) && pos[0] > (X_ELEVATOR_POS - 3.8) && pos[0] < (X_ELEVATOR_POS - 1.81))
		    {
		        // The player is most likely using an elevator floor button... check which floor
		        // -----------------------------------------------------------------------------

		        // Create variable with the number of floors to check (total floors minus 1)
				new i = 10;

				// Loop
				while(pos[2] < GetDoorsZCoordForFloor(i) + 3.5 && i > 0)
				    i --;

				if(i == 0 && pos[2] < GetDoorsZCoordForFloor(0) + 2.0)
				    i = -1;

				if (i <= 9)
				{
				    // Check if the elevator is not moving (idle or waiting)
				    if (ElevatorState != ELEVATOR_STATE_MOVING)
				    {
				        // Check if the elevator is already on the floor it was called from
				        if (ElevatorFloor == i + 1)
				        {
				            // Display gametext message to the player
							GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~y~~h~LS Apartments 1 Elevator Is~n~~y~~h~Already On This Floor...~n~~w~Walk Inside It~n~~w~And Press '~k~~CONVERSATION_YES~'", 3500, 3);

							// Display chat text message to the player
	                        SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, "* The LS Apartments 1 elevator is already on this floor... walk inside it and press '{FFFFFF}~k~~CONVERSATION_YES~{CCCCCC}'");

                            // Exit here (return 1 so this callback is processed in other scripts)
	                        return 1;
				        }
				    }

				    // Call function to call the elevator to the floor
					CallElevator(playerid, i + 1);

					// Display gametext message to the player
					GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~LS Apartments 1 Elevator~n~~g~~h~Has Been Called...~n~~w~Please Wait", 3000, 3);

					// Create variable for formatted message
					new strTempString[100];

					// Check if the elevator is moving
					if (ElevatorState == ELEVATOR_STATE_MOVING)
					{
					    // Format chat text message
						format(strTempString, sizeof(strTempString), "* The LS Apartments 1 elevator has been called... it is currently moving towards the %s.", FloorNames[ElevatorFloor]);
					}
					else
					{
					    // Check if the floor is the car park
					    if (ElevatorFloor == 0)
					    {
					    	// Format chat text message
							format(strTempString, sizeof(strTempString), "* The LS Apartments 1 elevator has been called... it is currently at the %s.", FloorNames[ElevatorFloor]);
						}
						else
						{
					    	// Format chat text message
							format(strTempString, sizeof(strTempString), "* The LS Apartments 1 elevator has been called... it is currently on the %s.", FloorNames[ElevatorFloor]);
						}
					}

					// Display formatted chat text message to the player
					SendClientMessage(playerid, COLOR_MESSAGE_YELLOW, strTempString);

					// Exit here (return 1 so this callback is processed in other scripts)
					return 1;
				}
		    }
		}
	}


    if(newkeys & KEY_CROUCH)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			foreach(new idx : Gates)
			{
				if(gData[idx][gModel] && IsPlayerInRangeOfPoint(playerid, 8.0, gData[idx][gCX], gData[idx][gCY], gData[idx][gCZ]))
				{
					if(gData[idx][gFaction] > 0)
					{
						if(gData[idx][gFaction] != pData[playerid][pFaction])
							return Error(playerid, "This gate only for faction.");
					}
					if(gData[idx][gFamily] > -1)
					{
						if(gData[idx][gFamily] != pData[playerid][pFamily])
							return Error(playerid, "This gate only for family.");
					}

					if(gData[idx][gVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level not enough to enter this gate.");

					if(gData[idx][gAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this gate.");

					if(strlen(gData[idx][gPass]))
					{
						new params[256];
						if(sscanf(params, "s[36]", params)) return Usage(playerid, "/gate [password]");
						if(strcmp(params, gData[idx][gPass])) return Error(playerid, "Invalid gate password.");
						if(!gData[idx][gStatus])
						{
							gData[idx][gStatus] = 1;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gOX], gData[idx][gOY], gData[idx][gOZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gORX], gData[idx][gORY], gData[idx][gORZ]);
						}
						else
						{
							gData[idx][gStatus] = 0;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gCX], gData[idx][gCY], gData[idx][gCZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gCRX], gData[idx][gCRY], gData[idx][gCRZ]);
						}
					}
					else
					{
						if(!gData[idx][gStatus])
						{
							gData[idx][gStatus] = 1;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gOX], gData[idx][gOY], gData[idx][gOZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gORX], gData[idx][gORY], gData[idx][gORZ]);
						}
						else
						{
							gData[idx][gStatus] = 0;
							MoveDynamicObject(gData[idx][gObjID], gData[idx][gCX], gData[idx][gCY], gData[idx][gCZ], gData[idx][gSpeed]);
							SetDynamicObjectRot(gData[idx][gObjID], gData[idx][gCRX], gData[idx][gCRY], gData[idx][gCRZ]);
						}
					}
					return 1;
				}
			}
		}
	}
    //Vote System
	if(VoteOn && VoteVoted[playerid] == 0)
	{
	    if(newkeys == KEY_YES)
	    {
	        VoteY++;
	        VoteVoted[playerid] = 1;
	        SendClientMessage(playerid, COLOR_RIKO, "[VOTE]{FFFFFF} Anda memilih {33AA33}IYA{FFFFFF}.");
		}
	    if(newkeys == KEY_NO)
	    {
		    VoteN++;
		    VoteVoted[playerid] = 1;
		    SendClientMessage(playerid, COLOR_RIKO, "[VOTE]{FFFFFF} Anda memilih {FF0000}TIDAK{FFFFFF}.");
	    }
	}
	if(PRESSED(KEY_FIRE) && GetPVarInt(playerid, "GraffitiCreating") == 0  && GetPlayerWeapon(playerid) == 41 )
	{
		if(!IsValidDynamicObject(POBJECT[playerid]))
    	{
		    spraytimerch[playerid] = SetTimerEx( "sprayingch", 1000, true, "i", playerid );
		    SetPVarInt(playerid, "GraffitiMenu", 1);
	    	return 1;
	    }
	    return ShowPlayerDialog(playerid, DIALOG_GDOBJECT, DIALOG_STYLE_MSGBOX, "Graffiti", "Anda sudah membuat graffiti\n\nJika anda ingin melanjutkan, text sebelumnya akan terhapus.", "Oke", "Cancel");
	}
	if(RELEASED( KEY_FIRE ) && GetPVarInt(playerid, "GraffitiMenu") == 1 && GetPlayerWeapon(playerid) == 41)
	{
	    KillTimer( spraytimerch[playerid] );
	    graffmenup[playerid] = 0;
	    DeletePVar(playerid, "GraffitiMenu");
	    return 1;
	}
	if( RELEASED( KEY_FIRE ) && GetPVarInt(playerid, "GraffitiCreating") == 1 )
	{
		if(GetPlayerWeapon(playerid) == 41 )
		{
		    KillTimer( spraytimer[playerid] );
	    	sprayammount[playerid] --;
    	 	spraytimerx[playerid] = SetTimerEx( "killgr", 90000, true, "i", playerid );
		}
	}
	if(newkeys == KEY_CROUCH)
   	{
      	if(IsPlayerInAnyVehicle(playerid))
      	{
        	return callcmd::paytoll(playerid);
      	}
   	}
   	/*if(newkeys == KEY_LOOK_BEHIND)
   	{
      	{
        	ShowPlayerDialog(playerid, DIALOG_VC, DIALOG_STYLE_LIST, "Vehicle Control", "Engine\nLock\nLights", "Select", "Cancel");
      	}
   	}*/
	//butcher
	if(newkeys & KEY_CTRL_BACK && !GetPVarInt(playerid,"InWork") && GetPVarInt(playerid,"OnWork"))
	{
	    if(IsPlayerInRangeOfPoint(playerid,2.0,940.1020,2127.6326,1011.0303))
	    {
	        ShowPlayerDialog(playerid,D_WORK_INFO,DIALOG_STYLE_MSGBOX,"Information","Butcher - Sidejob\n\n"WHITE_E"You have to stored 10 meat and select the meat.\n\n"GREEN_E"Green "WHITE_E"meat is spoiled.\nAs it will be a "RED_E"red "WHITE_E"square press the {f7ae11}Y{ffffff}\nTo "YELLOW_E"end the operation, press {f7ae11}N","Ok","");
	    }
	}
	if(newkeys & KEY_NO && !GetPVarInt(playerid,"MeatCheck"))
	{
		if(IsValidDynamicObject(playerobject[playerid][0])) DestroyDynamicObject(playerobject[playerid][0]);
		else if(IsValidDynamicObject(playerobject[playerid][1])) DestroyDynamicObject(playerobject[playerid][1]);
		SetPlayerVirtualWorld(playerid,0);
	    TogglePlayerControllable(playerid, 1);
	    SetCameraBehindPlayer(playerid);
	    DeletePVar(playerid,"InWork");
	}
	if(newkeys & KEY_YES && !GetPVarInt(playerid,"MeatCheck") && GetPVarInt(playerid,"InWork") && GetPVarInt(playerid,"OnWork"))
	{
		if(StoreMeat[playerid] == 0)
		{
		    if(GetPVarInt(playerid,"BadMeat"))
		    {
				new Float:x,Float:y,Float:z;
				GetDynamicObjectPos(playerobject[playerid][0],x,y,z);
				if(floatround(y) == 2127)
				{
				    StopDynamicObject(playerobject[playerid][0]);
				    MoveDynamicObject(playerobject[playerid][0],944.204345, y, z,2);
				    SetPVarInt(playerid,"MeatCheck",1);
				    StoreMeat[playerid] -= 1;
				}
				else
				{
					DestroyDynamicObject(playerobject[playerid][0]);
				    GoObject(playerid);
					GameTextForPlayer(playerid,"~r~BAD JOB",500,5);
				}
			}
			else GameTextForPlayer(playerid,"~r~BAD JOB",500,5);
		}
		Info(playerid, "Finish.");
		if(IsValidDynamicObject(playerobject[playerid][0])) DestroyDynamicObject(playerobject[playerid][0]);
		else if(IsValidDynamicObject(playerobject[playerid][1])) DestroyDynamicObject(playerobject[playerid][1]);
		SetPlayerVirtualWorld(playerid,0);
	    TogglePlayerControllable(playerid, 1);
	    SetCameraBehindPlayer(playerid);
	    DeletePVar(playerid,"InWork");
	}
    if((newkeys & KEY_NO) && HasTrash[playerid])
	{
		Trash_ResetPlayer(playerid);
		SendClientMessage(playerid, COLOR_JOB, "TRASHMASTER: {FFFFFF}Trash bag removed.");
	}
    if(Player_Fire_Enabled[playerid])
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(vehicleid)
			{
				new vehicle_modelid = GetVehicleModel(vehicleid);
				if(FIRE_INFO[vehicle_modelid - 400][fire_VALID])
				{
					if(PRESSED(KEY_SPRINT))
					{
						Player_Key_Sprint_Time[playerid] = gettime();
					}
					else if(RELEASED(KEY_SPRINT))
					{
						if(gettime() - Player_Key_Sprint_Time[playerid] > 1)
						{
							PlayerPlaySound(playerid, 1131, 0.0, 0.0, 0.0);

							new effect_object = CreateObject(18695, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0), effect_object2 = -1;
							AttachDynamicObjectToVehicle
							(
								effect_object, vehicleid,
								FIRE_INFO[vehicle_modelid - 400][fire_OFFSET_X], FIRE_INFO[vehicle_modelid - 400][fire_OFFSET_Y], FIRE_INFO[vehicle_modelid - 400][fire_OFFSET_Z],
								FIRE_INFO[vehicle_modelid - 400][fire_ROT_X], FIRE_INFO[vehicle_modelid - 400][fire_ROT_Y], FIRE_INFO[vehicle_modelid - 400][fire_ROT_Z]
							);

							if(FIRE_INFO[vehicle_modelid - 400][fire_MIRROR])
							{
								effect_object2 = CreateObject(18695, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
								AttachDynamicObjectToVehicle
								(
									effect_object2, vehicleid,
									-FIRE_INFO[vehicle_modelid - 400][fire_OFFSET_X], FIRE_INFO[vehicle_modelid - 400][fire_OFFSET_Y], FIRE_INFO[vehicle_modelid - 400][fire_OFFSET_Z],
									FIRE_INFO[vehicle_modelid - 400][fire_ROT_X], -FIRE_INFO[vehicle_modelid - 400][fire_ROT_Y], -FIRE_INFO[vehicle_modelid - 400][fire_ROT_Z]
								);
							}

							SetTimerEx("DestroyEffectObject", 100, false, "ii", effect_object, effect_object2);
						}
					}
				}
			}
		}
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_NO))
	{
	    if(pData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
		else if(pData[playerid][CarryingLog] == 0)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping metal ore.");
			DisablePlayerCheckpoint(playerid);
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping coal ore.");
			DisablePlayerCheckpoint(playerid);
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return Error(playerid, "This entrance is locked at the moment.");

				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != pData[playerid][pFamily])
						return Error(playerid, "This door only for family.");
				}

				if(dData[did][dVip] > pData[playerid][pVip])
					return Error(playerid, "Your VIP level not enough to enter this door.");

				if(dData[did][dAdmin] > pData[playerid][pAdmin])
					return Error(playerid, "Your admin level not enough to enter this door.");

				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");

					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}

				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				pData[playerid][pInDoor] = -1;
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "This bisnis is locked!");

				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);

				PlayAudioStreamForPlayer(playerid, bData[bid][bSong], bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], 15.0, 1);
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			pData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);

			StopAudioStreamForPlayer(playerid);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");

				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			pData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");

				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ]))
			{
				SetPlayerPositionEx(playerid, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ], fData[fid][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				//pData[playerid][pInBiz] = -1;
			}
        }
	}
	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == 0 && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
  		TaserData[playerid][TaserCharged] = false;

	    new Float: x, Float: y, Float: z, Float: health;
     	GetPlayerPos(playerid, x, y, z);
	    PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
	    ApplyAnimation(playerid, "KNIFE", "KNIFE_3", 4.1, 0, 1, 1, 0, 0, 1);
		pData[playerid][pActivityTime] = 0;
	    TaserData[playerid][ChargeTimer] = SetTimerEx("ChargeUp", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Recharge...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

	    for(new i, maxp = GetPlayerPoolSize(); i <= maxp; ++i)
		{
	        if(!IsPlayerConnected(i)) continue;
          	if(playerid == i) continue;
          	if(TaserData[i][TaserCountdown] != 0) continue;
          	if(IsPlayerInAnyVehicle(i)) continue;
			if(GetPlayerDistanceFromPoint(i, x, y, z) > 2.0) continue;
			ClearAnimations(i, 1);
			TogglePlayerControllable(i, false);
   			ApplyAnimation(i, "CRACK", "crckdeth2", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(i, 6003, 0.0, 0.0, 0.0);

			GetPlayerHealth(i, health);
			TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
   			Info(i, "You got tased for %d secounds!", TaserData[i][TaserCountdown]);
			TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
			break;
	    }
	}
	if((newkeys & KEY_CTRL_BACK ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::berry(playerid, "pickup");
		}
	}
	//Vehicle
	if((newkeys & KEY_YES ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::v(playerid, "engine");
		}
	}
	if((newkeys & KEY_NO ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::v(playerid, "lights");
		}
	}
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(pData[playerid][pEnergy] >= 100 )
		{
  			Info(playerid, " Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
		    pData[playerid][pEnergy] += 5;
		}
	}
	if(PRESSED( KEY_FIRE ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return Error(playerid, "This entrance is locked at the moment.");

						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != pData[playerid][pFamily])
								return Error(playerid, "This door only for family.");
						}

						if(dData[did][dVip] > pData[playerid][pVip])
							return Error(playerid, "Your VIP level not enough to enter this door.");

						if(dData[did][dAdmin] > pData[playerid][pAdmin])
							return Error(playerid, "Your admin level not enough to enter this door.");

						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");

							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
					}
				}
				new xid = pData[playerid][pInDoor];
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[xid][dIntposX], dData[xid][dIntposY], dData[xid][dIntposZ]))
				{
					if(dData[xid][dGarage] == 1)
					{
						if(dData[xid][dFaction] > 0)
						{
							if(dData[xid][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}

						if(dData[xid][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[xid][dExtposX], dData[xid][dExtposY], dData[xid][dExtposZ], dData[xid][dExtposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[xid][dExtposX], dData[xid][dExtposY], dData[xid][dExtposZ], dData[xid][dExtposA]);
						}
						pData[playerid][pInDoor] = -1;
						SetPlayerInterior(playerid, dData[xid][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[xid][dExtvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
					}
				}
			}
		}
	}
	//if(IsKeyJustDown(KEY_CTRL_BACK,newkeys,oldkeys))
	if(PRESSED( KEY_CTRL_BACK ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && pData[playerid][pCuffed] == 0)
		{
			ClearAnimations(playerid);
			StopLoopingAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			TextDrawHideForPlayer(playerid, txtAnimHelper);
		}
    }
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	//trasher
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(GetVehicleModel(vehicleid) == 408)
	    {
		    if(LoadedTrash[vehicleid] > 0)
		    {
		        new string[128];
		        format(string, sizeof(string), "TRASHMASTER: {FFFFFF}This vehicle has {F39C12}%d {FFFFFF}trash bags which is worth {2ECC71}$%d.", LoadedTrash[vehicleid], LoadedTrash[vehicleid] * TRASH_BAG_VALUE);
				SendClientMessage(playerid, COLOR_JOB, string);
				SendClientMessage(playerid, COLOR_JOB, "TRASHMASTER: {FFFFFF}You can sell your trash bags to recycling factories marked by a truck icon.");

				for(new i; i < sizeof(FactoryData); i++)
				{
				    FactoryIcons[playerid][i] = CreateDynamicMapIcon(FactoryData[i][FactoryX], FactoryData[i][FactoryY], FactoryData[i][FactoryZ], 51, 0, _, _, playerid, 8000.0, MAPICON_GLOBAL);
					TogglePlayerDynamicCP(playerid, FactoryData[i][FactoryCP], 1);
				}
		    }
		    else
		    {
		        SendClientMessage(playerid, COLOR_JOB, "TRASHMASTER: {FFFFFF}You can collect trash and sell them at recycling factories.");
		        SendClientMessage(playerid, COLOR_JOB, "TRASHMASTER: {FFFFFF}Find trash cans or dumpsters and use '/pickup'.");
		    }

			Trash_ShowCapacity(playerid);
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}

	if(oldstate == PLAYER_STATE_DRIVER)
	{
		for(new i; i < sizeof(FactoryData); i++)
		{
		    if(IsValidDynamicMapIcon(FactoryIcons[playerid][i]))
		    {
		        DestroyDynamicMapIcon(FactoryIcons[playerid][i]);
		        FactoryIcons[playerid][i] = -1;
		    }

			TogglePlayerDynamicCP(playerid, FactoryData[i][FactoryCP], 0);
		}

		PlayerTextDrawHide(playerid, CapacityText[playerid]);
		HidePlayerProgressBar(playerid, CapacityBar[playerid]);
	}
	Trash_ResetPlayer(playerid);
	//electrican
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(GetVehicleModel(vehicleid) == 552)
	    {
		   	SendClientMessage(playerid, 0x2ECC71FF, "ELECTRICAN: {FFFFFF}.");
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}
	if(newstate == PLAYER_STATE_WASTED && pData[playerid][pJail] < 1)
    {
		if(pData[playerid][pInjured] == 0)
        {
            pData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 99999);

            pData[playerid][pInt] = GetPlayerInterior(playerid);
            pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
        }
        else
        {
            pData[playerid][pHospital] = 1;
        }
	}
	//Spec Player
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(pData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(pData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					Servers(ii, ,"%s(%i) is now on foot.", pData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		if(pData[playerid][pInjured] == 1)
        {
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
        }
		foreach (new ii : Player) if(pData[ii][pSpec] == playerid)
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		TextDrawHideForPlayer(playerid, TextFare);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);/*RemoveFromVehicle(playerid);*/

		//SIMPLE
		PlayerTextDrawHide(playerid, SIMPLEFUEL[playerid]);
		PlayerTextDrawHide(playerid, SIMPLEDAMAGE[playerid]);
		PlayerTextDrawHide(playerid, SIMPLESPEED[playerid]);
		for(new txd; txd < 5; txd++)
		{
			TextDrawHideForPlayer(playerid, SIMPLEHUD[txd]);
		}
		TextDrawHideForPlayer(playerid, TextFare);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
		//MODERN
		PlayerTextDrawHide(playerid, AkuDamage[playerid]);
		PlayerTextDrawHide(playerid, AkuFuel[playerid]);
		PlayerTextDrawHide(playerid, AkuSpeed[playerid]);
		for(new txd; txd < 4; txd++)
		{
			TextDrawHideForPlayer(playerid, AkuVeh[txd]);
		}

		if(pData[playerid][pTaxiDuty] == 1)
		{
			pData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "You are no longer on taxi duty!");
		}
		if(pData[playerid][pFare] == 1)
		{
			KillTimer(pData[playerid][pFareTimer]);
			Info(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
			pData[playerid][pFare] = 0;
			pData[playerid][pTotalFare] = 0;
		}

        HidePlayerProgressBar(playerid, pData[playerid][fuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][damagebar]);

        /*HidePlayerProgressBar(playerid, pData[playerid][spfuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][spdamagebar]);*/
	}
	else if(newstate == PLAYER_STATE_DRIVER)
    {
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
				{
					if(pvData[pv][cLocked] == 1)
					{
						RemovePlayerFromVehicle(playerid);
						//new Float:slx, Float:sly, Float:slz;
						//GetPlayerPos(playerid, slx, sly, slz);
						//SetPlayerPos(playerid, slx, sly, slz);
						Error(playerid, "This bike is locked by owner.");
						return 1;
					}
				}
			}
		}
		if(newstate == PLAYER_STATE_DRIVER)
	    {
	        if(VehicleLastEnterTime[playerid] > gettime())
	        {
	            Warning[playerid]++;
	            if(Warning[playerid] >= 3)
	                AutoBan(playerid);
	        }
	        VehicleLastEnterTime[playerid] = gettime() + 2;
	    }
	    if(IsADmvVeh(vehicleid))
        {
            if(pData[playerid][pSekolahSim] == 0)
            {
                RemovePlayerFromVehicle(playerid);
                Error(playerid, " Anda Tidak Memulai {FFFF00}DMV {FFFFFF}Test");
			}
		}
		if(IsATrashVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_TRASH, DIALOG_STYLE_MSGBOX, "Side Job - Trashmaster", "Anda akan bekerja sebagai pengangkut sampah?", "Start Job", "Close");
		}
		if(IsAForVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Anda akan bekerja sebagai pemuat barang dengan Forklift?", "Start Job", "Close");
		}
		if(IsASweeperVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "Side Job - Sweeper", "Anda akan bekerja sebagai pembersih jalan?", "Start Job", "Close");
		}
		if(IsAPizzaVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_PIZZA, DIALOG_STYLE_MSGBOX, "Side Job - Pizza", "Anda akan bekerja sebagai pengantar Pizza?", "Start Job", "Close");
		}
		if(IsABusVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_LIST, "Side Job - Bus", "1.Route A\tOcean Docks\n2.Route B\tEast Side\n", "Start Job", "Close");
		}
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }
		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] <= 0)
        {
            Info(playerid, "You don't have {FFFF00}Driving Licenses{FFFFFF}, warning");
        }
		if(pData[playerid][pHBEMode] == 1)
		{
		    PlayerTextDrawShow(playerid, SIMPLEFUEL[playerid]);
			PlayerTextDrawShow(playerid, SIMPLEDAMAGE[playerid]);
			PlayerTextDrawShow(playerid, SIMPLESPEED[playerid]);
			for(new txd; txd < 5; txd++)
			{
				TextDrawShowForPlayer(playerid, SIMPLEHUD[txd]);
			}
		}
		else if(pData[playerid][pHBEMode] == 2)
		{
		    PlayerTextDrawShow(playerid, AkuDamage[playerid]);
			PlayerTextDrawShow(playerid, AkuFuel[playerid]);
			PlayerTextDrawShow(playerid, AkuSpeed[playerid]);
			for(new txd; txd < 4; txd++)
			{
				TextDrawShowForPlayer(playerid, AkuVeh[txd]);
			}
		}
		else
		{

		}
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;

		if(pData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(pData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    Servers(ii, "%s(%i) is now driving a %s(%d).", pData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid){ case 0..18, 39..54: return 1;} //invalid weapons
	if(1 <= weaponid <= 46 && pData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
	{
	   	pData[playerid][pAmmo][g_aWeaponSlots[weaponid]]--;
		if(pData[playerid][pGuns][g_aWeaponSlots[weaponid]] != 0 && !pData[playerid][pAmmo][g_aWeaponSlots[weaponid]])
		{
			pData[playerid][pGuns][g_aWeaponSlots[weaponid]] = 0;
		}
	}
	if(hittype == BULLET_HIT_TYPE_PLAYER && IsPlayerConnected(hitid) && !IsPlayerNPC(hitid))
    {
        new Float:Shot[3], Float:Hit[3];
        GetPlayerLastShotVectors(playerid, Shot[0], Shot[1], Shot[2], Hit[0], Hit[1], Hit[2]);

        new playersurf = GetPlayerSurfingVehicleID(playerid);
        new hitsurf = GetPlayerSurfingVehicleID(hitid);
        new Float:targetpackets = NetStats_PacketLossPercent(hitid);
        new Float:playerpackets = NetStats_PacketLossPercent(playerid);

        if(~(playersurf) && ~(hitsurf) && !IsPlayerInAnyVehicle(playerid) && !IsPlayerInAnyVehicle(hitid))
        {
            if(!IsPlayerAimingAtPlayer(playerid, hitid) && !IsPlayerInRangeOfPoint(hitid, 5.0, Hit[0], Hit[1], Hit[2]))
            {
                new String[10000], issuer[24];
                GetPlayerName(playerid, issuer, 24);
                AimbotWarnings[playerid] ++;

                format(String, sizeof(String), "{FFFFFF}Player %s warning of aimbot or lag [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);

                for(new p; p < MAX_PLAYERS;p++)
                    if(IsPlayerConnected(p) && IsPlayerAdmin(p))
                         SendClientMessage(p, -1, String);

                if(AimbotWarnings[playerid] > 10)
                {
                    if(targetpackets < 1.2 && playerpackets < 1.2) return Kick(playerid);
                    else
                    {
                        format(String, sizeof(String), "{FFFFFF}Player %s is probably using aimbot [Target PL: %f | Shooter PL:%f]!", issuer, targetpackets, playerpackets);
                        for(new p; p < MAX_PLAYERS;p++) if(IsPlayerConnected(p) && IsPlayerAdmin(p)) SendClientMessage(p, -1, String);
                    }
                }
                return 0;
            }
            else return 1;
        }
        else return 1;
    }
	return 1;
}

stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health = GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    if(pData[playerid][pSeatBelt] == 0 || pData[playerid][pHelmetOn] == 0)
    {
     	if(GetVehicleSpeed(vehicleid) <= 20)
     	{
     		GivePlayerHealth(playerid, -8);
     		return 1;
     	}
     	if(GetVehicleSpeed(vehicleid) <= 50)
     	{
     		GivePlayerHealth(playerid, -10);
     		return 1;
     	}
     	if(GetVehicleSpeed(vehicleid) <= 90)
     	{
     		GivePlayerHealth(playerid, -20);
     		return 1;
     	}
     	return 1;
    }
    if(pData[playerid][pSeatBelt] == 1 || pData[playerid][pHelmetOn] == 1)
     {
     	if(GetVehicleSpeed(vehicleid) <= 20)
     	{
     		GivePlayerHealth(playerid, -1);
     		return 1;
     	}
     	if(GetVehicleSpeed(vehicleid) <= 50)
     	{
     		GivePlayerHealth(playerid, -3);
     		return 1;
     	}
     	if(GetVehicleSpeed(vehicleid) <= 100)
     	{
     		GivePlayerHealth(playerid, -8);
     		return 1;
     	}
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{

	return 1;
}

public OnPlayerUpdate(playerid)
{
	//SAPD Tazer/Taser
	UpdateTazer(playerid);
	//Afk
	p_tick[playerid]++;
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);
	return 1;
}

task VehicleUpdate[40000]()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 15);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 200)
            {
               Info(GetVehicleDriver(i), "This vehicle is low on fuel. You must visit a fuel station!");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
	foreach(new ii : PVehicles)
	{
		if(IsValidVehicle(pvData[ii][cVeh]))
		{
			if(pvData[ii][cPlateTime] != 0 && pvData[ii][cPlateTime] <= gettime())
			{
				format(pvData[ii][cPlate], 32, "NoHave");
				SetVehicleNumberPlate(pvData[ii][cVeh], pvData[ii][cPlate]);
				pvData[ii][cPlateTime] = 0;
			}
			if(pvData[ii][cRent] != 0 && pvData[ii][cRent] <= gettime())
			{
				pvData[ii][cRent] = 0;
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, query);
				if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
				Iter_SafeRemove(PVehicles, ii, ii);
			}
		}
		if(pvData[ii][cClaimTime] != 0 && pvData[ii][cClaimTime] <= gettime())
		{
			pvData[ii][cClaimTime] = 0;
		}
	}
}

public OnVehicleDeath(vehicleid, killerid)
{
	foreach(new i : PVehicles)
	{
		if(pvData[i][cVeh] == vehicleid)
		{
			pvData[i][cDeath] = gettime() + 15;
		}
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	LoadedTrash[vehicleid] = 0;
	foreach(new ii : PVehicles)
	{
		if(vehicleid == pvData[ii][cVeh] && pvData[ii][cRent] == 0 && pvData[ii][cDeath] > gettime())
		{
			if(pvData[ii][cInsu] > 0)
    		{
				pvData[ii][cDeath] = 0;
				pvData[ii][cInsu]--;
				pvData[ii][cClaim] = 1;
				pvData[ii][cClaimTime] = gettime() + (1 * 86400);
				foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
        		{
            		Info(pid, "Kendaraan anda hancur dan anda masih memiliki insuransi, silahkan ambil di kantor sags setelah 24 jam.");
				}
				if(IsValidVehicle(pvData[ii][cVeh]))
					DestroyVehicle(pvData[ii][cVeh]);

				pvData[ii][cVeh] = INVALID_VEHICLE_ID;
			}
			else
			{
				foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
        		{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[pid][cID]);
					mysql_tquery(g_SQL, query);
					if(IsValidVehicle(pvData[ii][cVeh]))
						DestroyVehicle(pvData[ii][cVeh]);

					pvData[ii][cVeh] = INVALID_VEHICLE_ID;
            		Info(pid, "Kendaraan anda hancur dan tidak memiliki insuransi.");
					Iter_SafeRemove(PVehicles, ii, ii);
				}
				pvData[ii][cDeath] = 0;
			}
			return 1;
		}
	}
	return 1;
}

ptask PlayerVehicleUpdate[200](playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				SetValidVehicleHealth(vehicleid, 300.0);
				SwitchVehicleEngine(vehicleid, false);
				GameTextForPlayer(playerid, "~r~Totalled!", 2500, 3);
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pHBEMode] == 1)
			{
			    new Float:fDamage, fFuel, color1, color2;

				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);
				if(fDamage <= 350) fDamage = 0;
				else if(fDamage > 1000) fDamage = 1000;

				fFuel = GetVehicleFuel(vehicleid);

 				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				/*if(!GetEngineStatus(vehicleid))
				{
					PlayerTextDrawSetString(playerid, VehEngine[playerid], "~r~OFF");
				}
				else
				{
					PlayerTextDrawSetString(playerid, VehEngine[playerid], "~g~ON");
				}*/

				new str[10];
                format(str, sizeof(str), "%.1f", fDamage);
                PlayerTextDrawSetString(playerid, SIMPLEDAMAGE[playerid], str);

                format(str, sizeof(str), "%d", fFuel);
                PlayerTextDrawSetString(playerid, SIMPLEFUEL[playerid], str);

                format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid));
                PlayerTextDrawSetString(playerid, SIMPLESPEED[playerid], str);
			}
			else if(pData[playerid][pHBEMode] == 2)
			{
				new Float:fDamage, fFuel, color1, color2;

				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);

				if(fDamage <= 350) fDamage = 0;
				else if(fDamage > 1000) fDamage = 1000;

				fFuel = GetVehicleFuel(vehicleid);

				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;

				new str[10];
                format(str, sizeof(str), "%.1f", fDamage);
                PlayerTextDrawSetString(playerid, AkuDamage[playerid], str);

                format(str, sizeof(str), "%d", fFuel);
                PlayerTextDrawSetString(playerid, AkuFuel[playerid], str);

                format(str, sizeof(str), "%.0f", GetVehicleSpeed(vehicleid));
                PlayerTextDrawSetString(playerid, AkuSpeed[playerid], str);
			}
			else
			{

			}
		}
	}
}

PlayerUpDateNeedBar(playerid)
{
	new str[10];

 	format(str,sizeof(str),"%i%", pData[playerid][pHunger]);
	PlayerTextDrawSetString(playerid, DIGIENERGY[playerid],str);str="";

	format(str,sizeof(str),"%i%", pData[playerid][pEnergy]);
	PlayerTextDrawSetString(playerid, DIGIHUNGER[playerid],str);str="";

	format(str,sizeof(str),"%i%", pData[playerid][pHunger]);
	PlayerTextDrawSetString(playerid, DGEnergy[playerid],str);str="";

	format(str,sizeof(str),"%i%", pData[playerid][pEnergy]);
	PlayerTextDrawSetString(playerid, DGFood[playerid],str);str="";
	return true;
}

ptask PlayerUpdate[999](playerid)
{
	//Anti-Money Hack
	if(GetPlayerMoney(playerid) > pData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pData[playerid][pMoney]);
		//SendAdminMessage(COLOR_RED, "Possible money hacks detected on %s(%i). Check on this player. "LG_E"($%d).", pData[playerid][pName], playerid, GetPlayerMoney(playerid) - pData[playerid][pMoney]);
	}
	if(GetPVarInt(playerid,"Drug_Time"))
		{
			SetPVarInt(playerid,"Drug_Time",GetPVarInt(playerid,"Drug_Time") - 1);
			if(GetPVarInt(playerid,"Drug_Time") == 100) SetPlayerWeather(playerid, weather_id);
		}
	//Anti Armour Hacks
	new Float:A;
	GetPlayerArmour(playerid, A);
	if(A > 100)
	{
		new fmt_msg[128], string[5000];
		SetPlayerArmourEx(playerid, 0);
		SendClientMessageToAllEx(COLOR_BAN, "BotCmd: %s(%i) has been kicked by BOT.", pData[playerid][pName], playerid);
		format(fmt_msg, sizeof fmt_msg, "Reason: Armour Hacks");
        SendClientMessageToAll(COLOR_BAN, fmt_msg);
		AutoBan(playerid);
		format(string, sizeof string, "```\nWarning: %s Have Detected Armour Hack\n```",  pData[playerid][pName]);
		DCC_SendChannelMessage(g_discord_ban, string);
	}
	//Weapon AC
	if(pData[playerid][pSpawned] == 1)
    {
        if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
        {
            pData[playerid][pWeapon] = GetPlayerWeapon(playerid);

            if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 42 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
            {
				new string[5000];
                SendAdminWarn(COLOR_YELLOW, "%s (%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
                SetWeapons(playerid); //Reload old weapons
                format(string, sizeof string, "```\nWarning: %s Have Detected Weapon Hack [%s]\n```",  pData[playerid][pName], ReturnWeaponName(pData[playerid][pWeapon]));
		        DCC_SendChannelMessage(g_discord_ban, string);
            }
        }
    }
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static weaponid, ammo, objectslot, count, index;

		for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
		{
			GetPlayerWeaponData(playerid, i, weaponid, ammo);
			index = weaponid - 22;

			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);

				if (GetPlayerWeapon(playerid) != weaponid)
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);

				else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;

			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
				count++;

			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	if(pData[playerid][pJail] <= 0)
	{
		if(pData[playerid][pHunger] > 100)
		{
			pData[playerid][pHunger] = 100;
		}
		if(pData[playerid][pHunger] < 0)
		{
			pData[playerid][pHunger] = 0;
		}
		if(pData[playerid][pEnergy] > 100)
		{
			pData[playerid][pEnergy] = 100;
		}
		if(pData[playerid][pEnergy] < 0)
		{
			pData[playerid][pEnergy] = 0;
		}
	}
	if(pData[playerid][pHBEMode] == 2 && pData[playerid][IsLoggedIn] == true)
	{
		SetPlayerProgressBarValue(playerid, pData[playerid][hungrybar], pData[playerid][pHunger]);
		SetPlayerProgressBarColour(playerid, pData[playerid][hungrybar], ConvertHBEColor(pData[playerid][pHunger]));
		SetPlayerProgressBarValue(playerid, pData[playerid][energybar], pData[playerid][pEnergy]);
		SetPlayerProgressBarColour(playerid, pData[playerid][energybar], ConvertHBEColor(pData[playerid][pEnergy]));
		/*new strings[64]; //, tstr[64];
		format(strings, sizeof(strings), "%s", pData[playerid][pName]);
		PlayerTextDrawSetString(playerid, DPname[playerid], strings);
		PlayerTextDrawShow(playerid, DPname[playerid]);*/
	}
	if(pData[playerid][pHospital] == 1)
    {
		if(pData[playerid][pInjured] == 1)
		{
			SetPlayerPosition(playerid, -2028.32, -92.87, 1067.43, 275.78, 1);

			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, playerid + 100);

			SetPlayerCameraPos(playerid, -2024.67, -93.13, 1066.78);
			SetPlayerCameraLookAt(playerid, -2028.32, -92.87, 1067.43);
			ResetPlayerWeaponsEx(playerid);
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pInjured] = 0;
		}
		pData[playerid][pHospitalTime]++;
		new mstr[64];
		format(mstr, sizeof(mstr), "~n~~n~~n~~w~Recovering... %d", 15 - pData[playerid][pHospitalTime]);
		InfoTD_MSG(playerid, 1000, mstr);

		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
        if(pData[playerid][pHospitalTime] >= 15)
        {
            pData[playerid][pHospitalTime] = 0;
            pData[playerid][pHospital] = 0;
			pData[playerid][pHunger] = 50;
			pData[playerid][pEnergy] = 50;
			SetPlayerHealthEx(playerid, 50);
			pData[playerid][pSick] = 0;
			GivePlayerMoneyEx(playerid, -15000);
			SetPlayerHealthEx(playerid, 50);

            for (new i; i < 20; i++)
            {
                SendClientMessage(playerid, -1, "");
            }

			SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
            SendClientMessage(playerid, COLOR_WHITE, "Kamu telah keluar dari rumah sakit, kamu membayar {00FF00}$150.00 {FFFFFF}kerumah sakit.");
            SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");

			SetPlayerPosition(playerid, 1182.8778, -1324.2023, 13.5784, 269.8747);

            TogglePlayerControllable(playerid, 1);
            SetCameraBehindPlayer(playerid);

            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			ClearAnimations(playerid);
			pData[playerid][pSpawned] = 1;
			SetPVarInt(playerid, "GiveUptime", -1);
		}
    }
	if(pData[playerid][pInjured] == 1 && pData[playerid][pHospital] != 1)
    {
		new mstr[64];
        format(mstr, sizeof(mstr), "~r~/death ~w~for spawn to ~r~hospital");
		InfoTD_MSG(playerid, 1000, mstr);

		if(GetPVarInt(playerid, "GiveUptime") == -1)
		{
			SetPVarInt(playerid, "GiveUptime", gettime());
		}

		if(GetPVarInt(playerid,"GiveUptime"))
        {
            if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 100)
            {
                Info(playerid, "Now you can spawn, type '/death' for spawn to hospital.");
                SetPVarInt(playerid, "GiveUptime", 0);
            }
        }

        ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
        ApplyAnimation(playerid, "PED", "KO_skid_front", 4.0, 0, 0, 0, 1, 0, 1);
        SetPlayerHealthEx(playerid, 99999);
    }
	if(pData[playerid][pInjured] == 0 && pData[playerid][pGender] != 0) //Pengurangan Data
	{
		if(++ pData[playerid][pHungerTime] >= 150)
        {
            if(pData[playerid][pHunger] > 0)
            {
                pData[playerid][pHunger]--;
            }
            else if(pData[playerid][pHunger] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pHungerTime] = 0;
        }
        if(++ pData[playerid][pEnergyTime] >= 120)
        {
            if(pData[playerid][pEnergy] > 0)
            {
                pData[playerid][pEnergy]--;
            }
            else if(pData[playerid][pEnergy] <= 0)
            {
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pEnergyTime] = 0;
        }
		if(pData[playerid][pSick] == 1)
		{
			if(++ pData[playerid][pSickTime] >= 200)
			{
				if(pData[playerid][pSick] >= 1)
				{
					new Float:hp;
					GetPlayerHealth(playerid, hp);
					SetPlayerDrunkLevel(playerid, 8000);
					Info(playerid, "Sepertinya anda sakit, segeralah pergi ke dokter untuk treatment.");
					SetPlayerHealth(playerid, hp - 2);
					pData[playerid][pSickTime] = 0;
				}
			}
		}
	}

	//Jail Player
	if(pData[playerid][pJail] > 0)
	{
		if(pData[playerid][pJailTime] > 0)
		{
			pData[playerid][pJailTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be unjail in ~w~%d ~b~~h~seconds.", pData[playerid][pJailTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pJail] = 0;
			pData[playerid][pJailTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1482.0356,-1724.5726,13.5469,750, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E" %s(%d) have been un-jailed by the server. (times up)", pData[playerid][pName], playerid);
		}
	}
	//Arreset Player
	if(pData[playerid][pArrest] > 0)
	{
		if(pData[playerid][pArrestTime] > 0)
		{
			pData[playerid][pArrestTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be released in ~w~%d ~b~~h~seconds.", pData[playerid][pArrestTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pArrest] = 0;
			pData[playerid][pArrestTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1526.69, -1678.05, 5.89, 267.76, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			Info(playerid, "You have been auto release. (times up)");
		}
	}
	PlayerUpDateNeedBar(playerid);
}

CMD:pos(playerid, params[])
{
	if(pData[playerid][pAdmin] < 1)
		if(pData[playerid][pHelper] == 0)
			return PermissionError(playerid);

	new Float: x, Float: y, Float: z, interior, virtual_world;

	if(sscanf(params, "P<,>fff", x, y, z))
		return SendClientMessage(playerid, 0xCECECEFF, "Gunakan: /pos [x y z]");

	sscanf(params, "P<,>{fff}dd", interior, virtual_world);

	SetPlayerPosition(playerid, x, y, z, interior, virtual_world);
	return 1;
}

//trasher
public FillTrash(id)
{
	TrashData[id][TrashLevel]++;
	if(TrashData[id][TrashType] == TYPE_BIN && TrashData[id][TrashLevel] > 1) TrashData[id][TrashLevel] = 1;

	if(TrashData[id][TrashType] == TYPE_DUMPSTER) {
		if(TrashData[id][TrashLevel] == 1) TrashData[id][TrashTimer] = SetTimerEx("FillTrash", REFILL_TIME * 1000, false, "i", id);
		if(TrashData[id][TrashLevel] >= 2)
		{
			TrashData[id][TrashLevel] = 2;
			KillTimer(TrashData[id][TrashTimer]);
			TrashData[id][TrashTimer] = -1;
		}

		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TrashData[id][TrashLabel], E_STREAMER_COLOR, (TrashData[id][TrashLevel] == 1) ? 0xF39C12FF : 0x2ECC71FF);
		return 1;
	}

	Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TrashData[id][TrashLabel], E_STREAMER_COLOR, 0x2ECC71FF);
	return 1;
}
CMD:pickup(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You can't do at this moment.");
	new vehicleid = GetPVarInt(playerid, "LastVehicleID");
	if(GetVehicleModel(vehicleid) != 408) return Error(playerid, "Your last vehicle has to be a Trashmaster.");
    if(HasTrash[playerid]) return Error(playerid, "You're already carrying a trash bag.");
	new id = Trash_Closest(playerid);
	if(id == -1) return Error(playerid, "You're not near any trash.");
	if(TrashData[id][TrashLevel] < 1) return Error(playerid, "There's nothing here.");
    new Float: x, Float: y, Float: z;
    GetVehicleBoot(vehicleid, x, y, z);
    if(GetPlayerDistanceFromPoint(playerid, x, y, z) >= 30.0) return Error(playerid, "You're not near your Trashmaster.");
	TrashData[id][TrashLevel]--;
	KillTimer(TrashData[id][TrashTimer]);
    TrashData[id][TrashTimer] = SetTimerEx("FillTrash", REFILL_TIME * 1000, false, "i", id);
	TrashCP[playerid] = CreateDynamicCP(x, y, z, 3.0, .playerid = playerid);
	HasTrash[playerid] = true;
	ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0);
	SetPlayerAttachedObject(playerid, ATTACHMENT_INDEX, 1264, 6, 0.222, 0.024, 0.128, 1.90, -90.0, 0.0, 0.5,0.5, 0.5);

	Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TrashData[id][TrashLabel], E_STREAMER_COLOR, (TrashData[id][TrashLevel] == 0) ? 0xE74C3CFF : 0xF39C12FF);
	SendClientMessage(playerid, COLOR_JOB, "TRASHMASTER: {FFFFFF}You can press {FFFF00}N {FFFFFF}to remove the trash bag.");
	return 1;
}
CMD:trash(playerid, params[])
{
	new id = Trash_Closest(playerid);
	if(id == -1) return Error(playerid, "You're not near any trash.");
	if(TrashData[id][TrashLevel] < 1) return Error(playerid, "There's nothing here.");
    if(pData[playerid][pTrash] < 0)
				return Error(playerid, "Kamu tidak mempunyai sampah di inventory mu!.");
	pData[playerid][pTrash] -= 1;
	GivePlayerMoneyEx(playerid, 50);
	Servers(playerid, "Kamu Telah membuang sampah ke tempatnya dan mendapatkan uang {00FF00}$0.50!");
	return 1;
}
CMD:getmeat(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You can't do at this moment.");

    if(GetMeatBag[playerid]) return Error(playerid, "You're already put a meat bag.");

	StoremeatCP[playerid] = CreateDynamicCP(942.3542, 2117.8999, 1011.0303, 3.0, .playerid = playerid);
	GetMeatBag[playerid] = true;
	ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0);
	SetPlayerAttachedObject(playerid, ATTACHMENT_INDEX, 2805, 6, 0.222, 0.024, 0.128, 1.90, -90.0, 0.0, 0.5,0.5, 0.5);
	Meat--;
	Server_Save();
	return 1;
}
CMD:cu(playerid, params[])
{
    //for(new idx = 0; idx < MAX_TELEPON; idx ++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,5.0,1773.6583, -1015.3002, 23.9609) || IsPlayerInRangeOfPoint(playerid,5.0,1254.7303, -2059.5728, 59.5827))
		{
		    GivePlayerMoneyEx(playerid, -5);
			new ph;

			if(sscanf(params, "d", ph))
			{
				Usage(playerid, "/cu [phone number] 933 - Taxi Call | 911 - SAPD Crime Call | 922 - SAMD Medic Call");
				foreach(new ii : Player)
				{
					if(pData[ii][pMechDuty] == 1)
					{
						SendClientMessageEx(playerid, COLOR_GREEN, "Mekanik Duty: %s | PH: [%d]", ReturnName(ii), pData[ii][pPhone]);
					}
				}
				return 1;
			}
			if(ph == 911)
			{
				if(pData[playerid][pCallTime] >= gettime())
					return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				Info(playerid, "Warning: This number for emergency crime only! please wait for SAPD respon!");
				SendFactionMessage(1, COLOR_BLUE, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency crime! Ph: ["GREEN_E"Telp Umum"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));

				pData[playerid][pCallTime] = gettime() + 60;
			}
			if(ph == 922)
			{
				if(pData[playerid][pCallTime] >= gettime())
					return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				Info(playerid, "Warning: This number for emergency medical only! please wait for SAMD respon!");
				SendFactionMessage(3, COLOR_PINK2, "[EMERGENCY CALL] "WHITE_E"%s calling the emergency medical! Ph: ["GREEN_E"Telp Umum"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));

				pData[playerid][pCallTime] = gettime() + 60;
			}
			if(ph == 933)
			{
				if(pData[playerid][pCallTime] >= gettime())
					return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());

				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				Info(playerid, "Your calling has sent to the taxi driver. please wait for respon!");
				pData[playerid][pCallTime] = gettime() + 60;
				foreach(new tx : Player)
				{
					if(pData[tx][pJob] == 1 || pData[tx][pJob2] == 1)
					{
						SendClientMessageEx(tx, COLOR_YELLOW, "[TAXI CALL] "WHITE_E"%s calling the taxi for order! Ph: ["GREEN_E"Telp Umum"WHITE_E"] | Location: %s", ReturnName(playerid), pData[playerid][pPhone], GetLocation(x, y, z));
					}
				}
			}
			if(ph == pData[playerid][pPhone]) return Error(playerid, "Nomor sedang sibuk!");
			foreach(new ii : Player)
			{
				if(pData[ii][pPhone] == ph)
				{
					if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");

					if(pData[ii][pCall] == INVALID_PLAYER_ID)
					{
						pData[playerid][pCall] = ii;

						SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
						SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE form %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
						PlayerPlaySound(playerid, 3600, 0,0,0);
						PlayerPlaySound(ii, 6003, 0,0,0);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
						SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
						return 1;
					}
					else
					{
						Error(playerid, "Nomor ini sedang sibuk.");
						return 1;
					}
				}
			}
		}
	}

	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
        if(newstate)
        {
            FlashTime[vehicleid] = SetTimerEx("OnLightFlash", flashtime, true, "d", vehicleid);
        }
        if(!newstate)
        {
        	new panels, doors, lights, tires;

			KillTimer(FlashTime[vehicleid]);

			GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
            UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
        }
        return 1;
}

public DoGMX()
{
	SendRconCommand("gmx");
	return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	//butcher
    if(areaid == meatsp)
	{
	    if(!GetPVarInt(playerid,"OnWork"))
	    {
	    	ShowPlayerDialog(playerid,D_WORK,DIALOG_STYLE_MSGBOX,"Butcher Job","Do you want to start working on the Assembly line?","Yes","");
	    }
	    else ShowPlayerDialog(playerid,D_WORK,DIALOG_STYLE_MSGBOX,"Butcher Job","Do you want to finish working on the Assembly line?","Yes","");
	}
    foreach(new i : Player)
	{
	    if(GetPVarType(i, "BBArea"))
	    {
	        if(areaid == GetPVarInt(i, "BBArea"))
	        {
	            new station[256];
	            GetPVarString(i, "BBStation", station, sizeof(station));
	            if(!isnull(station))
				{
					PlayStream(playerid, station, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ"), 30.0, 1);
				 	Servers(playerid, "You Enter The Boombox Area");
	            }
				return 1;
	        }
	    }
	}
	for(new i; i < sizeof(pTollArea); i++)
	{
		if(areaid == pTollArea[i] && IsPlayerInAnyVehicle(playerid))
		{
			GameTextForPlayer(playerid, "~w~Pay Toll Area~n~~w~ Type ~r~'/paytoll' ~w~Or Press~r~ H", 1000, 3);
		}
	}
	return 1;
}

forward OnSecondTimer();
public OnSecondTimer()
{
	new minute;
	gettime(_, minute);

	foreach(new playerid : Player)
	{
		CallLocalFunction("OnPlayerTimer", "i", playerid);
	}
}

forward OnPlayerTimer(playerid);
public OnPlayerTimer(playerid)
{
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
		{
			if(packet == 1)
			{
				pData[playerid][pSmugglerTimer]++;

				if(pData[playerid][pSmugglerTimer] == 25)
					SendClientMessage(playerid, COLOR_LOGS, "JOB: {FFFFFF}Smuggling job is currently active!, use "YELLOW_E"'/findpacket'"WHITE_E" to trace the package"),
					pData[playerid][pSmugglerTimer] = 0;
			}
		}
		if(pData[playerid][pJob] == 8 || pData[playerid][pJob2] == 8)
		{
			if(packet == 2)
			{
				pData[playerid][pSmugglerTimer]++;

				if(pData[playerid][pSmugglerTimer] == 25)
					SendClientMessage(playerid, COLOR_LOGS, "JOB: {FFFFFF}Smuggling job is currently active!, use "YELLOW_E"'/findpacket'"WHITE_E" to trace the package"),
					pData[playerid][pSmugglerTimer] = 0;
			}
		}
	}
    return 1;
}

forward OnMinuteTimer();
public OnMinuteTimer()
{
	new hour, minute, second;
	gettime(hour, minute, second);

//	UpdateBet();

	switch(minute)
	{
		case 0:
		{
			if(hour == 0 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 2;
		        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

			if(hour == 1 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 2 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 7 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 2;
		        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 8 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 10 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

            if(hour == 11 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 2;
		        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 13 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 2;
		        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 15 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 2;
		        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 17 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }

		    if(hour == 20 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }
		}
	 	case 30:
		{
		    if(hour == 4 && taked == 0)
		    {
				DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }
		}
		case 20:
		{
		    if(hour == 12 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 2;
		        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }
		}
		case 22:
		{
      		if(hour == 21 && taked == 0)
		    {
		        DestroyDynamicObject(objectpacket);
		        packet = 1;
		        objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		        taked = 0;
		    }
		}
	}

	SetWorldTime(WorldTime);
	OnPlayersWorldTimeInit(hour, minute);

	return 1;
}

forward OnPlayersWorldTimeInit(hour, minute);
public OnPlayersWorldTimeInit(hour, minute)
{
	foreach(new playerid : Player)
	{
		SetPlayerTime(playerid, hour, minute);
	}
}

forward Packet(packetid);
public Packet(packetid)
{
	switch(packetid)
	{
		case 1:
		{
		    DestroyDynamicObject(objectpacket);
		    packet = 1;
		    objectpacket = CreateDynamicObject(11745, -1304.212036, 2525.925537, 87.532722-1, 0.0, 0.0, 0.0, 0);
		    taked = 0;
		}
		case 2:
		{
		    DestroyDynamicObject(objectpacket);
	        packet = 2;
	        objectpacket = CreateDynamicObject(11745, -127.492500, 2258.050048, 28.337009-1, 0.0, 0.0, 0.0, 0);
	        taked = 0;
		}
	}
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    foreach(new i : Player)
	{
	    if(GetPVarType(i, "BBArea"))
	    {
	        if(areaid == GetPVarInt(i, "BBArea"))
	        {
	            StopStream(playerid);
	            Servers(playerid, "You Has Been Leave Boombox Area");
				return 1;
	        }
	    }
	}
	return 1;
}

forward splits(const strsrc[], strdest[][], delimiter);
public splits(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
		if(strsrc[i]==delimiter || i==strlen(strsrc)){
			len = strmid(strdest[aNum], strsrc, li, i, 128);
			strdest[aNum][len] = 0;
			li = i+1;
			aNum++;
		}
		i++;
	}
	return 1;
}

CMD:setskill(playerid, params[])
{
	new choice[128], String[50], giveplayerid, amount;
	if(sscanf(params, "s[128]dd", choice, giveplayerid, amount))
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "USE: /setskill [trucker, mechanic, smuggler] [playerid] [amount]");
		return 1;
	}
	if(strcmp(choice, "mechanic", true) == 0)
	{
		pData[giveplayerid][pMechSkill] = amount;
		format(String, sizeof(String), "SKILLINFO: You've set %s mechanic Skill to Level %d", pData[giveplayerid][pName], amount);

		SendClientMessage(playerid, COLOR_WHITE, String);
	}
	else if(strcmp(choice, "trucker", true) == 0)
	{
		pData[giveplayerid][pTruckSkill] = amount;
		format(String, sizeof(String), "SKILLINFO: You've set %s trucker Skill to Level %d", pData[giveplayerid][pName], amount);

		SendClientMessage(playerid, COLOR_WHITE, String);
	}
	else if(strcmp(choice, "smuggler", true) == 0)
	{
		pData[giveplayerid][pSmuggSkill] = amount;
		format(String, sizeof(String), "SKILLINFO: You've set %s smuggler Skill to Level %d", pData[giveplayerid][pName], amount);

		SendClientMessage(playerid, COLOR_WHITE, String);
	}
	return 1;
}
ptask AfkCheck[1000](playerid)  {
	new str[300];
    if(p_tick[playerid] > 0) {
        p_tick[playerid] = 0, p_afktime[playerid] = 0;
        return 1;
    }
    if(p_tick[playerid] == 0) {
        p_afktime[playerid]++;
    }
    /*if(p_afktime[playerid] > 0) {
        format(str, sizeof str,"[ATIP] %d Second(s)",p_afktime[playerid]);
        SetPlayerChatBubble(playerid, str, COLOR_YELLOW, 10.0, 1000);
    }*/
    new afk_minutes = ConvertUnixTime(p_afktime[playerid], CONVERT_TIME_TO_MINUTES);
	new afk_seconds = ConvertUnixTime(p_afktime[playerid]);

	if(afk_minutes > 0)
	{
		format(str, sizeof str, "[ATIP] %d:%02d Minute(s).", afk_minutes, afk_seconds);
	}
	else format(str, sizeof str, "[ATIP] %d Seconds(s).", afk_seconds);
	SetPlayerChatBubble(playerid, str, COLOR_SYSTEM, 10.0, 1000);
    return 1;
}
stock ConvertUnixTime(unix_time, type = CONVERT_TIME_TO_SECONDS)
{
	switch(type)
	{
		case CONVERT_TIME_TO_SECONDS:
		{
			unix_time %= 60;
		}
		case CONVERT_TIME_TO_MINUTES:
		{
			unix_time = (unix_time / 60) % 60;
		}
		case CONVERT_TIME_TO_HOURS:
		{
			unix_time = (unix_time / 3600) % 24;
		}
		case CONVERT_TIME_TO_DAYS:
		{
			unix_time = (unix_time / 86400) % 30;
		}
		case CONVERT_TIME_TO_MONTHS:
		{
			unix_time = (unix_time / 2629743) % 12;
		}
		case CONVERT_TIME_TO_YEARS:
		{
			unix_time = (unix_time / 31556926) + 1970;
		}
		default:
			unix_time %= 60;
	}
	return unix_time;
}

