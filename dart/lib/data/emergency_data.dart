import '../models/contact.dart';

List<Contact> emergencyDatabase = [
  // --- NATIONAL TOLL-FREE (Dispatchers) ---
  Contact(name: "National Emergency (Police/Fire/Med)", phoneNumber: "112", category: "General", state: "Nationwide"),
  Contact(name: "Police Control Room (Nationwide)", phoneNumber: "199", category: "Police", state: "Nationwide"),
  Contact(name: "Federal Road Safety (FRSC)", phoneNumber: "122", category: "Road Safety", state: "Nationwide"),
  Contact(name: "NCDC (Health Emergency)", phoneNumber: "07087110839", category: "Hospital", state: "Nationwide"),

  // --- ABIA ---
  Contact(name: "Abia Police Command", phoneNumber: "08035415408", category: "Police", state: "Abia"),
  Contact(name: "Abia State Fire Service", phoneNumber: "08096001819", category: "Fire", state: "Abia"),
  Contact(name: "Abia State Ambulance", phoneNumber: "08145068414", category: "Hospital", state: "Abia"),

  // --- ADAMAWA ---
  Contact(name: "Adamawa Police Command", phoneNumber: "08089671313", category: "Police", state: "Adamawa"),
  Contact(name: "Adamawa Fire Service", phoneNumber: "112", category: "Fire", state: "Adamawa"),
  Contact(name: "Adamawa Health Line", phoneNumber: "112", category: "Hospital", state: "Adamawa"),

  // --- AKWA IBOM ---
  Contact(name: "Akwa Ibom Police Command", phoneNumber: "08039213071", category: "Police", state: "Akwa Ibom"),
  Contact(name: "Akwa Ibom Fire Service", phoneNumber: "112", category: "Fire", state: "Akwa Ibom"),
  Contact(name: "Akwa Ibom Health Service", phoneNumber: "112", category: "Hospital", state: "Akwa Ibom"),

  // --- ANAMBRA ---
  Contact(name: "Anambra Police Command", phoneNumber: "07039194332", category: "Police", state: "Anambra"),
  Contact(name: "Anambra State Fire", phoneNumber: "112", category: "Fire", state: "Anambra"),
  Contact(name: "Anambra Health Line", phoneNumber: "08030953771", category: "Hospital", state: "Anambra"),

  // --- BAUCHI ---
  Contact(name: "Bauchi Police Command", phoneNumber: "08151849417", category: "Police", state: "Bauchi"),
  Contact(name: "Bauchi Fire Service", phoneNumber: "112", category: "Fire", state: "Bauchi"),

  // --- BAYELSA ---
  Contact(name: "Bayelsa Police Command", phoneNumber: "07034578208", category: "Police", state: "Bayelsa"),
  Contact(name: "Bayelsa State Fire", phoneNumber: "112", category: "Fire", state: "Bayelsa"),

  // --- BENUE ---
  Contact(name: "Benue Police Command", phoneNumber: "08066006475", category: "Police", state: "Benue"),
  Contact(name: "Benue Fire Service", phoneNumber: "112", category: "Fire", state: "Benue"),

  // --- BORNO ---
  Contact(name: "Borno Police Command", phoneNumber: "08068075581", category: "Police", state: "Borno"),
  Contact(name: "Borno Fire Service", phoneNumber: "112", category: "Fire", state: "Borno"),

  // --- CROSS RIVER ---
  Contact(name: "Cross River Police Command", phoneNumber: "08133568456", category: "Police", state: "Cross River"),
  Contact(name: "C/River Fire Service", phoneNumber: "112", category: "Fire", state: "Cross River"),

  // --- DELTA ---
  Contact(name: "Delta Police Command", phoneNumber: "08036684974", category: "Police", state: "Delta"),
  Contact(name: "Delta State Fire", phoneNumber: "112", category: "Fire", state: "Delta"),
  Contact(name: "Delta Health Line", phoneNumber: "08033521961", category: "Hospital", state: "Delta"),

  // --- EBONYI ---
  Contact(name: "Ebonyi Police Command", phoneNumber: "07064515001", category: "Police", state: "Ebonyi"),
  Contact(name: "Ebonyi Fire Service", phoneNumber: "112", category: "Fire", state: "Ebonyi"),

  // --- EDO ---
  Contact(name: "Edo Police Command", phoneNumber: "08037646272", category: "Police", state: "Edo"),
  Contact(name: "Edo State Fire", phoneNumber: "112", category: "Fire", state: "Edo"),

  // --- EKITI ---
  Contact(name: "Ekiti Police Command", phoneNumber: "08062335577", category: "Police", state: "Ekiti"),
  Contact(name: "Ekiti Fire Service", phoneNumber: "112", category: "Fire", state: "Ekiti"),

  // --- ENUGU ---
  Contact(name: "Enugu Police Command", phoneNumber: "08032003702", category: "Police", state: "Enugu"),
  Contact(name: "Enugu Fire Service", phoneNumber: "112", category: "Fire", state: "Enugu"),

  // --- FCT ABUJA ---
  Contact(name: "FCT Police Command", phoneNumber: "08061581938", category: "Police", state: "FCT"),
  Contact(name: "Federal Fire Service HQ", phoneNumber: "08032003557", category: "Fire", state: "FCT"),
  Contact(name: "National Hospital Abuja", phoneNumber: "08097520012", category: "Hospital", state: "FCT"),

  // --- GOMBE ---
  Contact(name: "Gombe Police Command", phoneNumber: "08150567771", category: "Police", state: "Gombe"),
  Contact(name: "Gombe Fire Service", phoneNumber: "112", category: "Fire", state: "Gombe"),

  // --- IMO ---
  Contact(name: "Imo Police Command", phoneNumber: "08034773600", category: "Police", state: "Imo"),
  Contact(name: "Imo Fire Service", phoneNumber: "112", category: "Fire", state: "Imo"),

  // --- JIGAWA ---
  Contact(name: "Jigawa Police Command", phoneNumber: "08075391069", category: "Police", state: "Jigawa"),
  Contact(name: "Jigawa Fire Service", phoneNumber: "112", category: "Fire", state: "Jigawa"),

  // --- KADUNA ---
  Contact(name: "Kaduna Police Command", phoneNumber: "08123822284", category: "Police", state: "Kaduna"),
  Contact(name: "Kaduna Fire Service", phoneNumber: "112", category: "Fire", state: "Kaduna"),
  Contact(name: "Kaduna Health Line", phoneNumber: "08035871662", category: "Hospital", state: "Kaduna"),

  // --- KANO ---
  Contact(name: "Kano Police Command", phoneNumber: "08032419754", category: "Police", state: "Kano"),
  Contact(name: "Kano Fire Service", phoneNumber: "112", category: "Fire", state: "Kano"),
  Contact(name: "Kano Health Line", phoneNumber: "08039704476", category: "Hospital", state: "Kano"),

  // --- KATSINA ---
  Contact(name: "Katsina Police Command", phoneNumber: "08075391255", category: "Police", state: "Katsina"),
  Contact(name: "Katsina Fire Service", phoneNumber: "112", category: "Fire", state: "Katsina"),

  // --- KEBBI ---
  Contact(name: "Kebbi Police Command", phoneNumber: "08038797644", category: "Police", state: "Kebbi"),
  Contact(name: "Kebbi Fire Service", phoneNumber: "112", category: "Fire", state: "Kebbi"),

  // --- KOGI ---
  Contact(name: "Kogi Police Command", phoneNumber: "08075391335", category: "Police", state: "Kogi"),
  Contact(name: "Kogi Fire Service", phoneNumber: "112", category: "Fire", state: "Kogi"),

  // --- KWARA ---
  Contact(name: "Kwara Police Command", phoneNumber: "07032069501", category: "Police", state: "Kwara"),
  Contact(name: "Kwara Fire Service", phoneNumber: "112", category: "Fire", state: "Kwara"),

  // --- LAGOS ---
  Contact(name: "Lagos Police Control Room", phoneNumber: "08035963919", category: "Police", state: "Lagos"),
  Contact(name: "Lagos State Fire Service", phoneNumber: "08033234943", category: "Fire", state: "Lagos"),
  Contact(name: "Lagos Ambulance (LASAMBUS)", phoneNumber: "08022887788", category: "Hospital", state: "Lagos"),
  Contact(name: "Lagos Distress Call", phoneNumber: "767", category: "General", state: "Lagos"),

  // --- NASARAWA ---
  Contact(name: "Nasarawa Police Command", phoneNumber: "08123821571", category: "Police", state: "Nasarawa"),
  Contact(name: "Nasarawa Fire Service", phoneNumber: "112", category: "Fire", state: "Nasarawa"),

  // --- NIGER ---
  Contact(name: "Niger Police Command", phoneNumber: "08081777498", category: "Police", state: "Niger"),
  Contact(name: "Niger State Fire Service", phoneNumber: "112", category: "Fire", state: "Niger"),

  // --- OGUN ---
  Contact(name: "Ogun Police Command", phoneNumber: "08032136765", category: "Police", state: "Ogun"),
  Contact(name: "Ogun Fire Service", phoneNumber: "112", category: "Fire", state: "Ogun"),

  // --- ONDO ---
  Contact(name: "Ondo Police Command", phoneNumber: "07034313903", category: "Police", state: "Ondo"),
  Contact(name: "Ondo State Fire Service", phoneNumber: "112", category: "Fire", state: "Ondo"),

  // --- OSUN ---
  Contact(name: "Osun Police Command", phoneNumber: "08039537995", category: "Police", state: "Osun"),
  Contact(name: "Osun State Fire Service", phoneNumber: "08122695959", category: "Fire", state: "Osun"),

  // --- OYO ---
  Contact(name: "Oyo Police Command", phoneNumber: "08081768614", category: "Police", state: "Oyo"),
  Contact(name: "Oyo State Fire Service", phoneNumber: "112", category: "Fire", state: "Oyo"),
  Contact(name: "Oyo Health Line", phoneNumber: "08095394000", category: "Hospital", state: "Oyo"),

  // --- PLATEAU ---
  Contact(name: "Plateau Police Command", phoneNumber: "08126375938", category: "Police", state: "Plateau"),
  Contact(name: "Plateau Fire Service", phoneNumber: "112", category: "Fire", state: "Plateau"),

  // --- RIVERS ---
  Contact(name: "Rivers Police Command", phoneNumber: "08032003514", category: "Police", state: "Rivers"),
  Contact(name: "Rivers Fire Service", phoneNumber: "112", category: "Fire", state: "Rivers"),
  Contact(name: "Rivers Health Emergency", phoneNumber: "09046962204", category: "Hospital", state: "Rivers"),

  // --- SOKOTO ---
  Contact(name: "Sokoto Police Command", phoneNumber: "07068848035", category: "Police", state: "Sokoto"),
  Contact(name: "Sokoto Fire Service", phoneNumber: "112", category: "Fire", state: "Sokoto"),

  // --- TARABA ---
  Contact(name: "Taraba Police Command", phoneNumber: "08140089863", category: "Police", state: "Taraba"),
  Contact(name: "Taraba Fire Service", phoneNumber: "112", category: "Fire", state: "Taraba"),

  // --- YOBE ---
  Contact(name: "Yobe Police Command", phoneNumber: "07039301585", category: "Police", state: "Yobe"),
  Contact(name: "Yobe Fire Service", phoneNumber: "112", category: "Fire", state: "Yobe"),

  // --- ZAMFARA ---
  Contact(name: "Zamfara Police Command", phoneNumber: "08106580123", category: "Police", state: "Zamfara"),
  Contact(name: "Zamfara Fire Service", phoneNumber: "112", category: "Fire", state: "Zamfara"),
];