class CityList{
  List<String> cities=List<String>();
  List<String> cityListUpdate(String selectedState)
  {
    cities.clear();
    switch(selectedState) {
      case 'Any':
        cities.addAll(['Any']);
        break;
      case 'Andaman and Nicobar Islands':
        cities.addAll(['Port Blair']);
        break;
      case 'Andhra Pradesh':
        cities.addAll([
          'Adoni',
          'Amaravati',
          'Anantapur',
          'Chandragiri',
          'Chittoor',
          'Dowlaiswaram',
          'Eluru',
          'Guntur',
          'Kadapa',
          'Kakinada',
          'Kurnool',
          'Machilipatnam',
          'Nagarjunakoṇḍa',
          'Rajahmundry',
          'Srikakulam',
          'Tirupati',
          'Vijayawada',
          'Visakhapatnam',
          'Vizianagaram',
          'Yemmiganur',
        ]);
        break;
      case 'Arunachal Pradesh':
        cities.addAll(['Itanagar']);
        break;
      case 'Assam':
        cities.addAll([
          'Dhuburi',
          'Dibrugarh',
          'Dispur',
          'Guwahati',
          'Jorhat',
          'Nagaon',
          'Sibsagar',
          'Silchar',
          'Tezpur',
          'Tinsukia',
        ]);
        break;
      case 'Bihar':
        cities.addAll(['Ara',
          'Baruni',
          'Begusarai',
          'Bettiah',
          'Bhagalpur',
          'Bihar Sharif',
          'Bodh Gaya',
          'Buxar',
          'Chapra',
          'Darbhanga',
          'Dehri',
          'Dinapur Nizamat',
          'Gaya',
          'Hajipur',
          'Jamalpur',
          'Katihar',
          'Madhubani',
          'Motihari',
          'Munger',
          'Muzaffarpur',
          'Patna',
          'Purnia',
          'Pusa',
          'Saharsa',
          'Samastipur',
          'Sasaram',
          'Sitamarhi',
          'Siwan',
        ]);
        break;
      case 'Chandigarh':
        cities.addAll(['Chandigarh']);
        break;
      case 'Chhattisgarh':
        cities.addAll(['Ambikapur',
          'Bhilai',
          'Bilaspur',
          'Dhamtari',
          'Durg',
          'Jagdalpur',
          'Raipur',
          'Rajnandgaon']);
        break;
      case 'Dadra and Nagar Haveli':
        cities.addAll(['Dadra and Nagar Haveli']);
        break;
      case 'Daman and Diu':
        cities.addAll(['Daman and Diu']);
        break;
      case 'Delhi':
        cities.addAll(['Delhi']);
        break;
      case 'Goa':
        cities.addAll(['Madgaon', 'Panaji']);
        break;
      case 'Gujarat':
        cities.addAll(['Ahmadabad',
          'Amreli',
          'Bharuch',
          'Bhavnagar',
          'Bhuj',
          'Dwarka',
          'Gandhinagar',
          'Godhra',
          'Jamnagar',
          'Junagadh',
          'Kandla',
          'Khambhat',
          'Kheda',
          'Mahesana',
          'Morvi',
          'Nadiad',
          'Navsari',
          'Okha',
          'Palanpur',
          'Patan',
          'Porbandar',
          'Rajkot',
          'Surat',
          'Surendranagar',
          'Valsad',
          'Veraval']);
        break;
      case 'Haryana':
        cities.addAll(['Ambala',
          'Bhiwani',
          'Chandigarh',
          'Faridabad',
          'Firozpur Jhirka',
          'Gurugram',
          'Hansi',
          'Hisar',
          'Jind',
          'Kaithal',
          'Karnal',
          'Kurukshetra',
          'Panipat',
          'Pehowa',
          'Rewari',
          'Rohtak',
          'Sirsa',
          'Sonipat']);
        break;
      case 'Himachal Pradesh':
        cities.addAll(['Bilaspur',
          'Chamba',
          'Dalhousie',
          'Dharmshala',
          'Hamirpur',
          'Kangra',
          'Kullu',
          'Mandi',
          'Nahan',
          'Shimla',
          'Una']);
        break;
      case 'Jammu and Kashmir':
        cities.addAll(['Anantnag',
          'Baramula',
          'Doda',
          'Gulmarg',
          'Jammu',
          'Kathua',
          'Leh',
          'Punch',
          'Rajauri',
          'Srinagar',
          'Udhampur']);
        break;
      case 'Jharkhand':
        cities.addAll(['Bokaro',
          'Chaibasa',
          'Deoghar',
          'Dhanbad',
          'Dumka',
          'Giridih',
          'Hazaribag',
          'Jamshedpur',
          'Jharia',
          'Rajmahal',
          'Ranchi',
          'Saraikela']);
        break;
      case 'Karnataka':
        cities.addAll(['Badami',
          'Ballari',
          'Bangalore',
          'Belgavi',
          'Bhadravati',
          'Bidar',
          'Chikkamagaluru',
          'Chitradurga',
          'Davangere',
          'Halebid',
          'Hassan',
          'Hubballi-Dharwad',
          'Kalaburagi',
          'Kolar',
          'Madikeri',
          'Mandya',
          'Mangaluru',
          'Mysuru',
          'Raichur',
          'Shivamogga',
          'Shravanabelagola',
          'Shrirangapattana',
          'Tumkuru']);
        break;
      case 'Kerala':
        cities.addAll([
          'Alappuzha',
          'Badagara',
          'Idukki',
          'Kannur',
          'Kochi',
          'Kollam',
          'Kottayam',
          'Kozhikode',
          'Mattancheri',
          'Palakkad',
          'Thalassery',
          'Thiruvananthapuram',
          'Thrissur']);
        break;
      case 'Madhya Pradesh':
        cities.addAll(['Balaghat',
          'Barwani',
          'Betul',
          'Bharhut',
          'Bhind',
          'Bhojpur',
          'Bhopal',
          'Burhanpur',
          'Chhatarpur',
          'Chhindwara',
          'Damoh',
          'Datia',
          'Dewas',
          'Dhar',
          'Guna',
          'Gwalior',
          'Hoshangabad',
          'Indore',
          'Itarsi',
          'Jabalpur',
          'Jhabua',
          'Khajuraho',
          'Khandwa',
          'Khargon',
          'Maheshwar',
          'Mandla',
          'Mandsaur',
          'Mhow',
          'Morena',
          'Murwara',
          'Narsimhapur',
          'Narsinghgarh',
          'Narwar',
          'Neemuch',
          'Nowgong',
          'Orchha',
          'Panna',
          'Raisen',
          'Rajgarh',
          'Ratlam',
          'Rewa',
          'Sagar',
          'Sarangpur',
          'Satna',
          'Sehore',
          'Seoni',
          'Shahdol',
          'Shajapur',
          'Sheopur',
          'Shivpuri',
          'Ujjain',
          'Vidisha']);
        break;
      case 'Maharashtra':
        cities.addAll(['Ahmadnagar',
          'Akola',
          'Amravati',
          'Aurangabad',
          'Bhandara',
          'Bhusawal',
          'Bid',
          'Buldana',
          'Chandrapur',
          'Daulatabad',
          'Dhule',
          'Jalgaon',
          'Kalyan',
          'Karli',
          'Kolhapur',
          'Mahabaleshwar',
          'Malegaon',
          'Matheran',
          'Mumbai',
          'Nagpur',
          'Nanded',
          'Nashik',
          'Osmanabad',
          'Pandharpur',
          'Parbhani',
          'Pune',
          'Ratnagiri',
          'Sangli',
          'Satara',
          'Sevagram',
          'Solapur',
          'Thane',
          'Ulhasnagar',
          'Vasai-Virar',
          'Wardha',
          'Yavatmal']);
        break;
      case 'Manipur':
        cities.addAll(['Imphal']);
        break;
      case 'Meghalaya':
        cities.addAll(['Cherrapunji',
          'Shillong']);
        break;
      case 'Mizoram':
        cities.addAll(['Aizawl',
          'Lunglei']);
        break;
      case 'Nagaland':
        cities.addAll(['Kohima',
          'Mon',
          'Phek',
          'Wokha',
          'Zunheboto']);
        break;
      case 'Odisha':
        cities.addAll(['Balangir',
          'Baleshwar',
          'Baripada',
          'Bhubaneshwar',
          'Brahmapur',
          'Cuttack',
          'Dhenkanal',
          'Keonjhar',
          'Konark',
          'Koraput',
          'Paradip',
          'Phulabani',
          'Puri',
          'Sambalpur',
          'Udayagiri']);
        break;
      case 'Puducherry':
        cities.addAll(['Karaikal',
          'Mahe',
          'Puducherry',
          'Yanam']);
        break;
      case 'Punjab':
        cities.addAll(['Amritsar',
          'Batala',
          'Faridkot',
          'Firozpur',
          'Gurdaspur',
          'Hoshiarpur',
          'Jalandhar',
          'Kapurthala',
          'Ludhiana',
          'Nabha',
          'Patiala',
          'Rupnagar',
          'Sangrur']);
        break;
      case 'Rajasthan':
        cities.addAll(['Abu',
          'Ajmer',
          'Alwar',
          'Amer',
          'Barmer',
          'Beawar',
          'Bharatpur',
          'Bhilwara',
          'Bikaner',
          'Bundi',
          'Chittaurgarh',
          'Churu',
          'Dhaulpur',
          'Dungarpur',
          'Ganganagar',
          'Hanumangarh',
          'Jaipur',
          'Jaisalmer',
          'Jalor',
          'Jhalawar',
          'Jhunjhunu',
          'Jodhpur',
          'Kishangarh',
          'Kota',
          'Merta',
          'Nagaur',
          'Nathdwara',
          'Pali',
          'Phalodi',
          'Pushkar',
          'Sawai Madhopur',
          'Shahpura',
          'Sikar',
          'Sirohi',
          'Tonk',
          'Udaipur']);
        break;
      case 'Sikkim':
        cities.addAll(['Gangtok',
          'Gyalsing',
          'Lachung',
          'Mangan']);
        break;
      case 'Tamil Nadu':
        cities.addAll(['Arcot',
          'Chengalpattu',
          'Chennai',
          'Chidambaram',
          'Coimbatore',
          'Cuddalore',
          'Dharmapuri',
          'Dindigul',
          'Erode',
          'Kanchipuram',
          'Kanniyakumari',
          'Kodaikanal',
          'Kumbakonam',
          'Madurai',
          'Mamallapuram',
          'Nagappattinam',
          'Nagercoil',
          'Palayankottai',
          'Pudukkottai',
          'Rajapalaiyam',
          'Ramanathapuram',
          'Salem',
          'Thanjavur',
          'Tiruchchirappalli',
          'Tirunelveli',
          'Tiruppur',
          'Tuticorin',
          'Udhagamandalam',
          'Vellore']);
        break;
      case 'Telangana':
        cities.addAll(['Hyderabad',
          'Karimnagar',
          'Khammam',
          'Mahbubnagar',
          'Nizamabad',
          'Sangareddi',
          'Warangal']);
        break;
      case 'Tripura':
        cities.addAll(['Agartala']);
        break;
      case 'Uttar Pradesh':
        cities.addAll(['Agra',
          'Aligarh',
          'Amroha',
          'Ayodhya',
          'Azamgarh',
          'Bahraich',
          'Ballia',
          'Banda',
          'Bara Banki',
          'Bareilly',
          'Basti',
          'Bijnor',
          'Bithur',
          'Budaun',
          'Bulandshahr',
          'Deoria',
          'Etah',
          'Etawah',
          'Faizabad',
          'Farrukhabad-cum-Fatehgarh',
          'Fatehpur',
          'Fatehpur Sikri',
          'Ghaziabad',
          'Ghazipur',
          'Gonda',
          'Gorakhpur',
          'Hamirpur',
          'Hardoi',
          'Hathras',
          'Jalaun',
          'Jaunpur',
          'Jhansi',
          'Kannauj',
          'Kanpur',
          'Lakhimpur',
          'Lalitpur',
          'Lucknow',
          'Mainpuri',
          'Mathura',
          'Meerut',
          'Mirzapur-Vindhyachal',
          'Moradabad',
          'Muzaffarnagar',
          'Partapgarh',
          'Pilibhit',
          'Prayagraj',
          'Rae Bareli',
          'Rampur',
          'Saharanpur',
          'Sambhal',
          'Shahjahanpur',
          'Sitapur',
          'Sultanpur',
          'Tehri',
          'Varanasi']);
        break;
      case 'Uttarakhand':
        cities.addAll(['Almora',
          'Dehra Dun',
          'Haridwar',
          'Mussoorie',
          'Nainital',
          'Pithoragarh']);
        break;
      case 'West Bengal':
        cities.addAll(['Alipore',
          'Alipur Duar',
          'Asansol',
          'Baharampur',
          'Bally',
          'Balurghat',
          'Bankura',
          'Baranagar',
          'Barasat',
          'Barrackpore',
          'Basirhat',
          'Bhatpara',
          'Bishnupur',
          'Budge Budge',
          'Burdwan',
          'Chandernagore',
          'Darjiling',
          'Diamond Harbour',
          'Dum Dum',
          'Durgapur',
          'Halisahar',
          'Haora',
          'Hugli',
          'Ingraj Bazar',
          'Jalpaiguri',
          'Kalimpong',
          'Kamarhati',
          'Kanchrapara',
          'Kharagpur',
          'Koch Bihar',
          'Kolkata',
          'Krishnanagar',
          'Malda',
          'Midnapore',
          'Murshidabad',
          'Navadwip',
          'Palashi',
          'Panihati',
          'Purulia',
          'Raiganj',
          'Santipur',
          'Shantiniketan',
          'Shrirampur',
          'Siliguri',
          'Siuri',
          'Tamluk',
          'Titagarh']);
        break;
      default:
        cities.add('');
    }
    return cities;

    }
  List<String> cityListUpdateFilter(String selectedState)
  {
    cities.clear();
    switch(selectedState) {
      case 'Any':
        cities.addAll(['Any']);
        break;
      case 'Andaman and Nicobar Islands':
        cities.addAll(['Any','Port Blair']);
        break;
      case 'Andhra Pradesh':
        cities.addAll(['Any',
          'Adoni',
          'Amaravati',
          'Anantapur',
          'Chandragiri',
          'Chittoor',
          'Dowlaiswaram',
          'Eluru',
          'Guntur',
          'Kadapa',
          'Kakinada',
          'Kurnool',
          'Machilipatnam',
          'Nagarjunakoṇḍa',
          'Rajahmundry',
          'Srikakulam',
          'Tirupati',
          'Vijayawada',
          'Visakhapatnam',
          'Vizianagaram',
          'Yemmiganur',
        ]);
        break;
      case 'Arunachal Pradesh':
        cities.addAll(['Any','Itanagar']);
        break;
      case 'Assam':
        cities.addAll(['Any',
          'Dhuburi',
          'Dibrugarh',
          'Dispur',
          'Guwahati',
          'Jorhat',
          'Nagaon',
          'Sibsagar',
          'Silchar',
          'Tezpur',
          'Tinsukia',
        ]);
        break;
      case 'Bihar':
        cities.addAll(['Any','Ara',
          'Baruni',
          'Begusarai',
          'Bettiah',
          'Bhagalpur',
          'Bihar Sharif',
          'Bodh Gaya',
          'Buxar',
          'Chapra',
          'Darbhanga',
          'Dehri',
          'Dinapur Nizamat',
          'Gaya',
          'Hajipur',
          'Jamalpur',
          'Katihar',
          'Madhubani',
          'Motihari',
          'Munger',
          'Muzaffarpur',
          'Patna',
          'Purnia',
          'Pusa',
          'Saharsa',
          'Samastipur',
          'Sasaram',
          'Sitamarhi',
          'Siwan',
        ]);
        break;
      case 'Chandigarh':
        cities.addAll(['Any','Chandigarh']);
        break;
      case 'Chhattisgarh':
        cities.addAll(['Any','Ambikapur',
          'Bhilai',
          'Bilaspur',
          'Dhamtari',
          'Durg',
          'Jagdalpur',
          'Raipur',
          'Rajnandgaon']);
        break;
      case 'Dadra and Nagar Haveli':
        cities.addAll(['Dadra and Nagar Haveli']);
        break;
      case 'Daman and Diu':
        cities.addAll(['Daman and Diu']);
        break;
      case 'Delhi':
        cities.addAll(['Delhi']);
        break;
      case 'Goa':
        cities.addAll(['Any','Madgaon', 'Panaji']);
        break;
      case 'Gujarat':
        cities.addAll(['Any','Ahmadabad',
          'Amreli',
          'Bharuch',
          'Bhavnagar',
          'Bhuj',
          'Dwarka',
          'Gandhinagar',
          'Godhra',
          'Jamnagar',
          'Junagadh',
          'Kandla',
          'Khambhat',
          'Kheda',
          'Mahesana',
          'Morvi',
          'Nadiad',
          'Navsari',
          'Okha',
          'Palanpur',
          'Patan',
          'Porbandar',
          'Rajkot',
          'Surat',
          'Surendranagar',
          'Valsad',
          'Veraval']);
        break;
      case 'Haryana':
        cities.addAll(['Any','Ambala',
          'Bhiwani',
          'Chandigarh',
          'Faridabad',
          'Firozpur Jhirka',
          'Gurugram',
          'Hansi',
          'Hisar',
          'Jind',
          'Kaithal',
          'Karnal',
          'Kurukshetra',
          'Panipat',
          'Pehowa',
          'Rewari',
          'Rohtak',
          'Sirsa',
          'Sonipat']);
        break;
      case 'Himachal Pradesh':
        cities.addAll(['Any','Bilaspur',
          'Chamba',
          'Dalhousie',
          'Dharmshala',
          'Hamirpur',
          'Kangra',
          'Kullu',
          'Mandi',
          'Nahan',
          'Shimla',
          'Una']);
        break;
      case 'Jammu and Kashmir':
        cities.addAll(['Any','Anantnag',
          'Baramula',
          'Doda',
          'Gulmarg',
          'Jammu',
          'Kathua',
          'Leh',
          'Punch',
          'Rajauri',
          'Srinagar',
          'Udhampur']);
        break;
      case 'Jharkhand':
        cities.addAll(['Any','Bokaro',
          'Chaibasa',
          'Deoghar',
          'Dhanbad',
          'Dumka',
          'Giridih',
          'Hazaribag',
          'Jamshedpur',
          'Jharia',
          'Rajmahal',
          'Ranchi',
          'Saraikela']);
        break;
      case 'Karnataka':
        cities.addAll(['Any','Badami',
          'Ballari',
          'Bangalore',
          'Belgavi',
          'Bhadravati',
          'Bidar',
          'Chikkamagaluru',
          'Chitradurga',
          'Davangere',
          'Halebid',
          'Hassan',
          'Hubballi-Dharwad',
          'Kalaburagi',
          'Kolar',
          'Madikeri',
          'Mandya',
          'Mangaluru',
          'Mysuru',
          'Raichur',
          'Shivamogga',
          'Shravanabelagola',
          'Shrirangapattana',
          'Tumkuru']);
        break;
      case 'Kerala':
        cities.addAll(['Any',
          'Alappuzha',
          'Badagara',
          'Idukki',
          'Kannur',
          'Kochi',
          'Kollam',
          'Kottayam',
          'Kozhikode',
          'Mattancheri',
          'Palakkad',
          'Thalassery',
          'Thiruvananthapuram',
          'Thrissur']);
        break;
      case 'Madhya Pradesh':
        cities.addAll(['Any','Balaghat',
          'Barwani',
          'Betul',
          'Bharhut',
          'Bhind',
          'Bhojpur',
          'Bhopal',
          'Burhanpur',
          'Chhatarpur',
          'Chhindwara',
          'Damoh',
          'Datia',
          'Dewas',
          'Dhar',
          'Guna',
          'Gwalior',
          'Hoshangabad',
          'Indore',
          'Itarsi',
          'Jabalpur',
          'Jhabua',
          'Khajuraho',
          'Khandwa',
          'Khargon',
          'Maheshwar',
          'Mandla',
          'Mandsaur',
          'Mhow',
          'Morena',
          'Murwara',
          'Narsimhapur',
          'Narsinghgarh',
          'Narwar',
          'Neemuch',
          'Nowgong',
          'Orchha',
          'Panna',
          'Raisen',
          'Rajgarh',
          'Ratlam',
          'Rewa',
          'Sagar',
          'Sarangpur',
          'Satna',
          'Sehore',
          'Seoni',
          'Shahdol',
          'Shajapur',
          'Sheopur',
          'Shivpuri',
          'Ujjain',
          'Vidisha']);
        break;
      case 'Maharashtra':
        cities.addAll(['Any','Ahmadnagar',
          'Akola',
          'Amravati',
          'Aurangabad',
          'Bhandara',
          'Bhusawal',
          'Bid',
          'Buldana',
          'Chandrapur',
          'Daulatabad',
          'Dhule',
          'Jalgaon',
          'Kalyan',
          'Karli',
          'Kolhapur',
          'Mahabaleshwar',
          'Malegaon',
          'Matheran',
          'Mumbai',
          'Nagpur',
          'Nanded',
          'Nashik',
          'Osmanabad',
          'Pandharpur',
          'Parbhani',
          'Pune',
          'Ratnagiri',
          'Sangli',
          'Satara',
          'Sevagram',
          'Solapur',
          'Thane',
          'Ulhasnagar',
          'Vasai-Virar',
          'Wardha',
          'Yavatmal']);
        break;
      case 'Manipur':
        cities.addAll(['Imphal']);
        break;
      case 'Meghalaya':
        cities.addAll(['Any','Cherrapunji',
          'Shillong']);
        break;
      case 'Mizoram':
        cities.addAll(['Any','Aizawl',
          'Lunglei']);
        break;
      case 'Nagaland':
        cities.addAll(['Any','Kohima',
          'Mon',
          'Phek',
          'Wokha',
          'Zunheboto']);
        break;
      case 'Odisha':
        cities.addAll(['Any','Balangir',
          'Baleshwar',
          'Baripada',
          'Bhubaneshwar',
          'Brahmapur',
          'Cuttack',
          'Dhenkanal',
          'Keonjhar',
          'Konark',
          'Koraput',
          'Paradip',
          'Phulabani',
          'Puri',
          'Sambalpur',
          'Udayagiri']);
        break;
      case 'Puducherry':
        cities.addAll(['Any','Karaikal',
          'Mahe',
          'Puducherry',
          'Yanam']);
        break;
      case 'Punjab':
        cities.addAll(['Any','Amritsar',
          'Batala',
          'Faridkot',
          'Firozpur',
          'Gurdaspur',
          'Hoshiarpur',
          'Jalandhar',
          'Kapurthala',
          'Ludhiana',
          'Nabha',
          'Patiala',
          'Rupnagar',
          'Sangrur']);
        break;
      case 'Rajasthan':
        cities.addAll(['Any','Abu',
          'Ajmer',
          'Alwar',
          'Amer',
          'Barmer',
          'Beawar',
          'Bharatpur',
          'Bhilwara',
          'Bikaner',
          'Bundi',
          'Chittaurgarh',
          'Churu',
          'Dhaulpur',
          'Dungarpur',
          'Ganganagar',
          'Hanumangarh',
          'Jaipur',
          'Jaisalmer',
          'Jalor',
          'Jhalawar',
          'Jhunjhunu',
          'Jodhpur',
          'Kishangarh',
          'Kota',
          'Merta',
          'Nagaur',
          'Nathdwara',
          'Pali',
          'Phalodi',
          'Pushkar',
          'Sawai Madhopur',
          'Shahpura',
          'Sikar',
          'Sirohi',
          'Tonk',
          'Udaipur']);
        break;
      case 'Sikkim':
        cities.addAll(['Any','Gangtok',
          'Gyalsing',
          'Lachung',
          'Mangan']);
        break;
      case 'Tamil Nadu':
        cities.addAll(['Any','Arcot',
          'Chengalpattu',
          'Chennai',
          'Chidambaram',
          'Coimbatore',
          'Cuddalore',
          'Dharmapuri',
          'Dindigul',
          'Erode',
          'Kanchipuram',
          'Kanniyakumari',
          'Kodaikanal',
          'Kumbakonam',
          'Madurai',
          'Mamallapuram',
          'Nagappattinam',
          'Nagercoil',
          'Palayankottai',
          'Pudukkottai',
          'Rajapalaiyam',
          'Ramanathapuram',
          'Salem',
          'Thanjavur',
          'Tiruchchirappalli',
          'Tirunelveli',
          'Tiruppur',
          'Tuticorin',
          'Udhagamandalam',
          'Vellore']);
        break;
      case 'Telangana':
        cities.addAll(['Any','Hyderabad',
          'Karimnagar',
          'Khammam',
          'Mahbubnagar',
          'Nizamabad',
          'Sangareddi',
          'Warangal']);
        break;
      case 'Tripura':
        cities.addAll(['Agartala']);
        break;
      case 'Uttar Pradesh':
        cities.addAll(['Any','Agra',
          'Aligarh',
          'Amroha',
          'Ayodhya',
          'Azamgarh',
          'Bahraich',
          'Ballia',
          'Banda',
          'Bara Banki',
          'Bareilly',
          'Basti',
          'Bijnor',
          'Bithur',
          'Budaun',
          'Bulandshahr',
          'Deoria',
          'Etah',
          'Etawah',
          'Faizabad',
          'Farrukhabad-cum-Fatehgarh',
          'Fatehpur',
          'Fatehpur Sikri',
          'Ghaziabad',
          'Ghazipur',
          'Gonda',
          'Gorakhpur',
          'Hamirpur',
          'Hardoi',
          'Hathras',
          'Jalaun',
          'Jaunpur',
          'Jhansi',
          'Kannauj',
          'Kanpur',
          'Lakhimpur',
          'Lalitpur',
          'Lucknow',
          'Mainpuri',
          'Mathura',
          'Meerut',
          'Mirzapur-Vindhyachal',
          'Moradabad',
          'Muzaffarnagar',
          'Partapgarh',
          'Pilibhit',
          'Prayagraj',
          'Rae Bareli',
          'Rampur',
          'Saharanpur',
          'Sambhal',
          'Shahjahanpur',
          'Sitapur',
          'Sultanpur',
          'Tehri',
          'Varanasi']);
        break;
      case 'Uttarakhand':
        cities.addAll(['Any','Almora',
          'Dehra Dun',
          'Haridwar',
          'Mussoorie',
          'Nainital',
          'Pithoragarh']);
        break;
      case 'West Bengal':
        cities.addAll(['Any','Alipore',
          'Alipur Duar',
          'Asansol',
          'Baharampur',
          'Bally',
          'Balurghat',
          'Bankura',
          'Baranagar',
          'Barasat',
          'Barrackpore',
          'Basirhat',
          'Bhatpara',
          'Bishnupur',
          'Budge Budge',
          'Burdwan',
          'Chandernagore',
          'Darjiling',
          'Diamond Harbour',
          'Dum Dum',
          'Durgapur',
          'Halisahar',
          'Haora',
          'Hugli',
          'Ingraj Bazar',
          'Jalpaiguri',
          'Kalimpong',
          'Kamarhati',
          'Kanchrapara',
          'Kharagpur',
          'Koch Bihar',
          'Kolkata',
          'Krishnanagar',
          'Malda',
          'Midnapore',
          'Murshidabad',
          'Navadwip',
          'Palashi',
          'Panihati',
          'Purulia',
          'Raiganj',
          'Santipur',
          'Shantiniketan',
          'Shrirampur',
          'Siliguri',
          'Siuri',
          'Tamluk',
          'Titagarh']);
        break;
      default:
        cities.add('');
    }
    return cities;

  }
}


