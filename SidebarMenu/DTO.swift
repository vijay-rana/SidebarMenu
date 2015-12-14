//
//  UserDTO.swift
//  SidebarMenu
//
//  Created by KBS on 11/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation



struct Ex {
    static var UnknownError = "Some unknown error occured"
}

struct  UserDTO {
    var userid : Int = 0
    var username = ""
    var password = ""
    var roll_id : Int = 0
    var status = ""
    var add_date  = ""
    var quick_access = ""
}


struct  ClientDetailDTO {
    var clientid : Int = 0
    var first_name = ""
    var last_name = ""
    var dob = ""
    var newsletter_status: Bool = false
    var email  = ""
    var kin_name  = ""
    var hear_frm:Int = 0
    var telephone  = ""
    var kin_telephone  = ""
    
}

struct  ClientDTO_Static {
    static var clientid : Int = 0
    static var first_name = ""
    static var last_name = ""
    static var dob = ""
    static var newsletter_status: Bool = false
    static var email  = ""
    static var kin_name  = ""
    static var hear_frm:Int = 0
    static var telephone  = ""
    static var kin_telephone  = ""
    
}

struct  TherapistDTO {
    var skin_type1 : Int = 0
    var  area1   : Int = 0
    var  area2   : Int = 0
    var  area3   : Int = 0
    var  area4  : Int = 0
    var  value1    : Int = 0
    var  value2  : Int = 0
    var  value3   : Int = 0
    var  value4   : Int = 0
    var  skin_type2   : Int = 0
    var  hair_color   : Int = 0
    var  clientid   : Int = 0
    var ingrow_hairs: Bool = false
    var comments = ""
}

struct  TherapistDTO_Static {
    static var skin_type1 : Int = 0
    static var  area1   : Int = 0
    static var  area2   : Int = 0
    static var  area3   : Int = 0
    static var  area4  : Int = 0
    static var  value1    : Int = 0
    static var  value2  : Int = 0
    static var  value3   : Int = 0
    static var  value4   : Int = 0
    static var  skin_type2   : Int = 0
    static var  hair_color   : Int = 0
    static var  clientid   : Int = 0
    static var ingrow_hairs: Bool = false
    static var comments = ""
}





struct TreatmentNotesDTO {
    var  clientid   : Int = 0
    var  note_id   : Int = 0
    var  therapist_id   : Int = 0
    var  area_treated_id   : Int = 0
    var imgstring = ""
    var notes_date = ""
    var fluence = ""
    var energy = ""
    var new_medication = ""
    var client_sign = ""
    var therapist_sign = ""
    
}



struct ClientDTO {
    
   static var client_id: Int  = 0
    static var note_id: Int  = 0
    
}

struct User {
    static var roleid: Int  = 0
    static var QuickAccess: String = ""
}


struct Collection
{
    static var Static_list:Array<String> = []
    static var Static_HearAboutDicLst = [String: String]()
    static var Static_listTherapistArea:Array<String> = []
    static var Static_listTherapist:Array<String> = []
    static var Static_dicLstTherapistArea = [String: String]()
    static var Static_dicLstTherapist = [String: String]()
    static var Static_listColors:Array<String> = []
    static var Static_dicLstColors = [String: String]()
    static var Static_listSkinTypeValues:Array<String> = []
    static var Static_dicLstSkinTypeValues = [String: String]()
    
    static var Static_listTherapistValues:Array<String> = []
    
    
     static var Static_listTreatmentNotesDTO:Array<TreatmentNotesDTO> = []
    
    
    
    
}

struct Question
{
    static var Q1: String = ""
    static var Q2: String = ""
    static var Q3: String = ""
    static var Q4: String = ""
    static var Q5: String = ""
    static var Q6: String = ""
    static var Q7: String = ""
    static var Q8: String = ""
    static var Q9: String = ""
    static var Q10: String = ""
    static var Q11: String = ""
    static var Q12: String = ""
    static var Q13: String = ""
    static var Q14: String = ""
    static var Q15: String = ""
    static var Q16: String = ""
    static var Q17: String = ""
    static var Q18: String = ""
    static var Q19: String = ""
    static var Q20: String = ""
    static var Q21: String = ""
    static var Q22: String = ""
    static var Q23: String = ""
    static var Q24: String = ""
    static var Q25: String = ""
    static var Q26: String = ""
    static var Q27: String = ""
    static var Q28: String = ""
    static var Q29: String = ""
    static var Q30: String = ""
    static var Q31: String = ""
    static var Q32: String = ""
    static var Q33: String = ""
    
    static var S1: Bool = false
    static var S2: Bool = false
    static var S3: Bool = false
    static var S4: Bool = false
    static var S5: Bool = false
    static var S6: Bool = false
    static var S7: Bool = false
    static var S8: Bool = false
    static var S9: Bool = false
    static var S10: Bool = false
    static var S11: Bool = false
    static var S12: Bool = false
    static var S13: Bool = false
    static var S14: Bool = false
    static var S15: Bool = false
    static var S16: Bool = false
    static var S17: Bool = false
    static var S18: Bool = false
    static var S19: Bool = false
    static var S20: Bool = false
    static var S21: Bool = false
    static var S22: Bool = false
    static var S23: Bool = false
    static var S24: Bool = false
    static var S25: Bool = false
    static var S26: Bool = false
    static var S27: Bool = false
    static var S28: Bool = false
    static var S29: Bool = false
    static var S30: Bool = false
    static var S31: Bool = false
    static var S32: Bool = false
    static var S33: Bool = false
}


struct  Aggrement
{
    static var PatientSig: String = ""
    static var TherapistSig: String = ""
    static var Date: String = ""
    
}

struct Segue
{
    static var SegueId: String = ""
    static var IsJustUnlocked: Bool = false
}


enum SegueId {    
   case  Open_Client
  case   Open_GMQ
   case  Open_Contradiction
  case   Open_Caution
   case  Open_Aggrement
  case  Open_SkinDetail
    case GotoTreatmentNotesEdit
    case Open_ManageUser
}
