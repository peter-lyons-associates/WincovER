package gov.lbl.aercalc.model
{
	import flash.filesystem.File;
	import flash.system.Capabilities;
	
	import mx.logging.LogEventLevel;
	
	import gov.lbl.aercalc.util.AboutInfo;

	[Bindable]
	public class ApplicationModel
	{
		
		
		/* STATIC CONSTANTS */

		//If you are publishing multiple versions of WincovER with different id's in AERCalc5-app.xml (e.g. AERCalc5_India, AERCalc5_PCR)
		//You should update the following BASE_STORAGE_PATH_DIRNAME so that it has the same name as your id
		//For example, if you've updated the id to AERCalc5_India, you should update the 
		//BASE_STORAGE_PATH_DIRNAME variable to "AERCalc5_India"

		// ****** IMPORTANT *********
		// VERSION INFO 
		// THESE MUST BE UPDATED AT EACH RELEASE
			
		// WincovER version itself is in AboutInfo: AboutInfo.applicationVersion
		
		
		//Even though we get W7 version from import
		//xml list, we want a constant defined here
		//so we can immediately flag rows without having
		//to do an initial import and parse the xml
		public static const VERSION_WINDOW:String				= "7.7.01";
		public static const VERSION_ENERGYPLUS:String			= "8.5.0";
		public static const VERSION_WINCOVER_CALC:String		= "0.0.1";
		public static const VERSION_THERM:String				= "7.7.01";

		public static const BASE_STORAGE_PATH_DIRNAME:String 	= "AppData/LBNL/aercalc";
		public static const ENERGY_PLUS_SUBDIR:String 			= "EnergyPlus/";
		public static const ENERGY_PLUS_MAC_SUBDIR:String		= "EnergyPlusMac/";
		public static const ENERGY_PLUS_INC_DIR:String 			= ENERGY_PLUS_SUBDIR + "IncFiles/";
		public static const ENERGY_PLUS_INPUT_DIR:String 		= ENERGY_PLUS_SUBDIR + "Input/";
		public static const ENERGY_PLUS_WEATHER_DIR:String 		= ENERGY_PLUS_SUBDIR + "weather/";
		public static const ENERGY_PLUS_OUTPUT_DIR:String 		= ENERGY_PLUS_SUBDIR + "Output/";
		public static const BSDF_SUBDIR:String 					= "bsdf/";
		public static const AERCALC_DB_SUBDIR:String 			= "db/";
		public static const WINDOW_SUBDIR:String 				= "W7/";	 //setting to var so we can switch to W7 during development
		public static const THERM_SUBDIR:String 				= "THERM/";	 
		public static const THERM_FILES_SUBDIR:String 			= "AERC_sample_THERM_files/";
		public static const EPCALC_SUBDIR:String 				= "EP_Weighting_Scripts_ESCalc/";		
		public static const EPCALC_OUTPUT:String 				= EPCALC_SUBDIR + "Output/";
		public static const ESCALC_EXE_FILE_NAME:String 		= "ESCalc.exe";

		//Used on first startup to find DB within Application directory,
		//then full path is saved to DBManager.dbPath

		public static const AERCALC_DEFAULT_DB_NAME:String 	= "wincover.sqlite";
        public static const AERCALC_DEFAULT_DB_PATH:String 	= AERCALC_DB_SUBDIR + AERCALC_DEFAULT_DB_NAME;

		public static var WINDOW_EXE_FILE_PATH:String 			= WINDOW_SUBDIR + "W7.exe";
		public static var WINDOW_LOGS_FILE_PATH:String 			=  WINDOW_SUBDIR + "W7.log";
		public static var WINDOW_MDB_FILE_PATH:String 			=  WINDOW_SUBDIR + "AERCalSample.mdb";
		public static var WINDOW_MDB_LOCK_FILE_PATH:String 		= WINDOW_SUBDIR + "AERCalSample.ldb";
		public static var WINDOW_INI_FILE_PATH:String 			=  WINDOW_SUBDIR + "W7.ini";
		public static var WINDOW_INI_TEMPLATE_FILE_PATH:String 	=  WINDOW_SUBDIR + "W7_template.ini";
		public static var WINDOW_DEFAULT_MDB_FILE_PATH:String 	=  WINDOW_SUBDIR + "AERCalSample.mdb";
		
		public static var THERM_EXE_FILE_PATH:String 			= THERM_SUBDIR + "THERM7.exe";

		public static const AERCALC_LOG_FILE_PATH:String		= "logs/";
		public static const AERCALC_LOG_FILE_NAME:String 		= "aercalc-log.txt";
		public static const APP_SETTINGS_FILE_PATH:String 		= "settings/aercalc-settings.xml";

		public static const AIR_INFILTRATION_DEFAULT:Number 	= 0.01016002;  	// SI value m3/sm2  = 2 cfm/ft2		

		public static var currUnits:String	= "IP";
		public static var logEventLevel:int = LogEventLevel.DEBUG;		



		/* Main view states */
		public static const VIEW_WINDOW_LIST:String = "windowList";
		// ... future states go here



		/* INSTANCE VARS */

		// The current loaded roject
		public var currProjectDir:File;
		public var currProjectDB:File;

		private var _viewing:String = VIEW_WINDOW_LIST;

		//this is set to true if this is the first time the application is run
		public var isFirstStartup:Boolean = false;
			
		//copy a version of an empty DB so it's easier to track changes		
		public var useEmptyTestDB:Boolean = false;
		//always act like this is the first run of this version (which means we'll wipe out the files stored in the user's WincovER folder)
		public var alwaysFirstRun:Boolean = false;
		
		// if you set this to true, whenever you run a simulation, WincovER will just read in the
		// data from results/dummydataResults as if it was just generated by E+
		public var useEnergyPlusDummyData:Boolean = false;
			
		//string describing current tasks of loading process
		public var loadingProgress:String = ""; 
			
		public var menuEnabled:Boolean = true;	


		public function ApplicationModel()
		{
		}


		public function get viewing():String
		{
			return _viewing
		}

		public function set viewing(v:String):void
		{
			_viewing = v
		}

		public static function get baseStorageDir():File
		{
			// create a new File object each time...
			var baseStorageDir:File = File.userDirectory.resolvePath(BASE_STORAGE_PATH_DIRNAME);
			return baseStorageDir;
		}

		public function getCurrentProjectBSDFDir():File{
			return this.currProjectDir.resolvePath("bsdf/");
		}
		
	}
}