final List<String> doctors_specialization_category = ["All", "Cardiologist", "Dermatologist", "Pediatrician", "Neurologist", "General Physician"];
final List<Map<String, dynamic>> doctors_list_data = [
  // Cardiologists
  {
    "doctorImage": "assets/images/doctor-with-his-arms-crossed-white-background.png",
    "doctorRatings": 4.8,
    "doctorName": "Dr. John Smith",
    "doctorSpecialization": "Cardiologist",
    "doctorFees": 1200,
  },
  {
    "doctorImage": "assets/images/doctor.png",
    "doctorRatings": 4.7,
    "doctorName": "Dr. Carlos Fernandez",
    "doctorSpecialization": "Cardiologist",
    "doctorFees": 1300,
  },
  {
    "doctorImage": "assets/images/doctor (1).png",
    "doctorRatings": 4.5,
    "doctorName": "Dr. Ravi Rao",
    "doctorSpecialization": "Cardiologist",
    "doctorFees": 1250,
  },
  {
    "doctorImage": "assets/images/doctor (3).png",
    "doctorRatings": 4.6,
    "doctorName": "Dr. Linda Jackson",
    "doctorSpecialization": "Cardiologist",
    "doctorFees": 1280,
  },

  // Dermatologists
  {
    "doctorImage": "assets/images/doctor (3).png",
    "doctorRatings": 4.5,
    "doctorName": "Dr. Anjali Patel",
    "doctorSpecialization": "Dermatologist",
    "doctorFees": 800,
  },
  {
    "doctorImage": "assets/images/nutritionist.png",
    "doctorRatings": 4.4,
    "doctorName": "Dr. Neha Sharma",
    "doctorSpecialization": "Dermatologist",
    "doctorFees": 1000,
  },
  {
    "doctorImage": "assets/images/nutritionist.png",
    "doctorRatings": 4.5,
    "doctorName": "Dr. Sneha Bose",
    "doctorSpecialization": "Dermatologist",
    "doctorFees": 1150,
  },
  {
    "doctorImage": "assets/images/doctor (4).png",
    "doctorRatings": 4.6,
    "doctorName": "Dr. Alice Cooper",
    "doctorSpecialization": "Dermatologist",
    "doctorFees": 950,
  },

  // Pediatricians
  {
    "doctorImage": "assets/images/doctor (2).png",
    "doctorRatings": 4.6,
    "doctorName": "Dr. Grace Lee",
    "doctorSpecialization": "Pediatrician",
    "doctorFees": 950,
  },
  {
    "doctorImage": "assets/images/doctor (4).png",
    "doctorRatings": 4.6,
    "doctorName": "Dr. Priya Singh",
    "doctorSpecialization": "Pediatrician",
    "doctorFees": 980,
  },
  {
    "doctorImage": "assets/images/doctor (1).png",
    "doctorRatings": 4.4,
    "doctorName": "Dr. Rebecca Morris",
    "doctorSpecialization": "Pediatrician",
    "doctorFees": 990,
  },
  {
    "doctorImage": "assets/images/doctor (2).png",
    "doctorRatings": 4.7,
    "doctorName": "Dr. Rahul Kapoor",
    "doctorSpecialization": "Pediatrician",
    "doctorFees": 970,
  },

  // Neurologists
  {
    "doctorImage": "assets/images/doctor (4).png",
    "doctorRatings": 4.9,
    "doctorName": "Dr. Aamir Khan",
    "doctorSpecialization": "Neurologist",
    "doctorFees": 1500,
  },
  {
    "doctorImage": "assets/images/nutritionist.png",
    "doctorRatings": 4.7,
    "doctorName": "Dr. Yuto Tanaka",
    "doctorSpecialization": "Neurologist",
    "doctorFees": 1350,
  },
  {
    "doctorImage": "assets/images/nutritionist.png",
    "doctorRatings": 4.7,
    "doctorName": "Dr. Omar Al-Mansoori",
    "doctorSpecialization": "Neurologist",
    "doctorFees": 1600,
  },
  {
    "doctorImage": "assets/images/doctor (3).png",
    "doctorRatings": 4.8,
    "doctorName": "Dr. Min-Jae Kim",
    "doctorSpecialization": "Neurologist",
    "doctorFees": 1400,
  },

  // General Physicians
  {
    "doctorImage": "assets/images/doctor (1).png",
    "doctorRatings": 4.6,
    "doctorName": "Dr. Emily Wilson",
    "doctorSpecialization": "General Physician",
    "doctorFees": 600,
  },
  {
    "doctorImage": "assets/images/doctor (2).png",
    "doctorRatings": 4.3,
    "doctorName": "Dr. Susan Clark",
    "doctorSpecialization": "General Physician",
    "doctorFees": 880,
  },
  {
    "doctorImage": "assets/images/doctor (4).png",
    "doctorRatings": 4.2,
    "doctorName": "Dr. Michael Brown",
    "doctorSpecialization": "General Physician",
    "doctorFees": 700,
  },
  {
    "doctorImage": "assets/images/doctor.png",
    "doctorRatings": 4.4,
    "doctorName": "Dr. Thomas Evans",
    "doctorSpecialization": "General Physician",
    "doctorFees": 750,
  },
];

List<Map<String, dynamic>> extractFilteredDrs(String filter){
  return doctors_list_data
  .where((doctor) => doctor["doctorSpecialization"] == filter).toList();
}