// Flutter imports:
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class Prefs {
  static const String isFirstTimeUser = "isFirstTimeUser";
  static const String user = "user";
  static const String basicDetails = "basicDetails";
  static const String profileDetails = "profileDetails";
}

abstract class RemoteConfigVariables {
  static const String buildNumber = "build_number";
  static const String forceUpdate = "force_update";
}

abstract class EditProfileFields {
  static const String mobile = "MOB";
  static const String email = "EMAL";
}

abstract class StoreUrl {
  static const String playStore =
      "https://play.google.com/store/apps/details?id=";
  static const String appStore = "https://apps.apple.com/in/app/empower/id";
}

abstract class NotificationChannel {
  static const String channelHighId = "high_importance_channel";
  static const String channelHighName = "High Importance Notifications";
  static const String channelLowId = "low_importance_channel";
  static const String channelLowName = "Low Importance Notifications";
  static const int foregroundServiceNotificationId = 888;
}

abstract class AppRegexp {
  static final RegExp textRegExp = RegExp(r"[a-zA-Z]");
  static final RegExp textDigitsRegExp = RegExp(r"[a-zA-Z0-9]");
  static final RegExp digitsRegExp = RegExp(r'\d+');
  static final RegExp digits10RegExp = RegExp(r'\d{10}');
  static final RegExp digitsWithSingleDecimalRegExp =
      RegExp(r'^\d+(?:\.\d+)?$');

  static final RegExp nameRegExp =
      RegExp(r"[a-zA-Z]+(\s+[a-zA-Z]+)*"); //(?! ) -> not include space
  static final RegExp passwordRegExp = RegExp(r'[a-zA-Z0-9]+([a-zA-Z0-9]+)*');
  static final RegExp emailRegex = RegExp(
      r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp ifscRegex = RegExp(r"[A-Z]{4}0[0-9A-Za-z]{6}");

  static final RegExp pinCodeRegExp =
      RegExp(r"[0-9]{5,6}(?:-[0-9]{4})?"); //or zipcode ,zip+4
  static final RegExp gstRegExp =
      RegExp(r"\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[A-Z]{1}[A-Z\d]{1}");
  static final RegExp urlRegExp = RegExp(
      r"(?:http(s)?://)?[\w.-]+(?:\.[\w.-]+)+[\w\-._~:/?#[\]@!$&'()*+,;=]+$");
  static final RegExp abnRegExp = RegExp(r"(\d *?){11}");
}

double getStatusBarHeight(context) {
  return (MediaQuery.of(context).viewPadding.top);
}

abstract class MyProfileType {
  static const String aboutUs = "About Us";

  // static const String eRegistration = "E-Registration";
  static const String termsAndCondition = "Terms & Conditions";
  static const String contactUs = 'Contact Us';
  static const String privacyPolicy = 'Privacy Policy';

  static const String eRegistrationApplicationCharges =
      'E-Registration Application Charges';
  static const String eRegistrationRequirements = 'E-Registration Requirements';
  static const String userAgreement = 'User Agreement';
}

abstract class FilterDataType {
  static const String checkbox = "CHECKBOX";
  static const String rate = "RATING";
  static const String radio = "RADIO";
  static const String filter = 'FILTER';
}

/// Common Case Type values are used in Notification and My Services
abstract class CommonCaseType {
  static const String refund = "REFUND";
  static const String registration = "REG";
  static const String finalSettlement = "FS2";
  static const String clearanceCertificate = 'COC';
}

abstract class CaseActionStatus {
  static const String y = "Y";
  static const String r = "R";
  static const String p = "P";
  static const String d = "D";
  static const String a = "A";
  static const String pr = "PR";
}

abstract class VatStatus {
  static const String updated = "u";
  static const String inProgress = "i";
  static const String rejected = "r";
}

abstract class TrackRegPaymentType {
  static const String settlement = "FS";
  static const String registration = "RS";
}

abstract class TicketCharacteristicType {
  static const String discondt = "DISCONDT";
  static const String recondt = "RECONDT";
  static const String billId = "BILID";
}

abstract class ContactInfoType {
  static const String landline = "Landline Number";
  static const String mobile = "Mobile Number";
  static const String international = "International Number";
}

abstract class ErrorCodes {
  static const String errorCode400 = "Error Code 400 : Bad request";
  static const String errorCode401 = "Error Code 401 : Unauthorized";
  static const String errorCode403 = "Error Code 403 : Forbidden";

  static const String errorCode1 = "Error Code 1 : Something went wrong";

  static const String errorCode10 = "Error Code 10 : User exiting from app";
  static const String errorCode11 =
      "Error Code 11 : Unable to wipe user data from app";
}

abstract class DocType {
  static const String emid = "EM-ID";
  static const String trdlic = "TRDLIC";
  static const String passport = "PASSPORT";
}

abstract class BusinessUnitType {
  static const String emp = "EMP";
  static const String pdc = "PDC";
  static const String snow = "SNOW";
}

abstract class PremiseStatus {
  static const String allowed = "Y";
  static const String notAllowed = "N";
}

enum ToastType {
  success(true),
  error(false);

  const ToastType(this.value);

  final bool value;

  static ToastType fromValue(bool? value) {
    switch (value) {
      case true:
        return success;
      case false:
        return error;
      default:
        return error;
    }
  }

  Color get toColor {
    if (this == success) {
      return Colors.black;
    }
    return Colors.red;
  }
}

//StatusEnum.fromValue(item.status) == StatusTypeEnum.active
//StatusEnum.fromValue(item.status).toColor,
enum StatusEnum {
  active('Active'),
  connected('Connected'),
  disconnected('Disconnected'),
  inActive('InActive'),
  requestedUnderReview('Request under review'),
  certificateOfClearance('Certificate of Clearance'),
  documentRequestUnderReview('Document/Request under review'),
  waitingForPayment('Waiting for Payment'),
  cancelled('Cancelled'),
  closed('Closed'),

  /// updated for my services
  waitingForDocuments('Waiting for document(s)'),
  documentsBeingReviewed('Document(s) being reviewed'),
  underProcess('Under process'),
  registrationRequestUnderProcess('Registration request under process'),

  /// updated for My Tickets
  pending('Pending'),
  updateDocument('Update Document'),
  waitingForAdditionalDetails('Waiting for additional details'),
  waitingForFieldActivityCompletion('Waiting for FieldActivity Completion'),
  waitingForApproval('Waiting for approval'),
  rejected('Rejected'),
  error('');

  const StatusEnum(this.value);

  final String value;

  static StatusEnum fromValue(String? value) {
    switch (value) {
      case 'Active':
        return active;
      case 'Connected':
        return connected;
      case 'Disconnected':
        return disconnected;
      case 'InActive':
        return inActive;
      case 'Request under review':
        return requestedUnderReview;
      case 'Certificate of Clearance':
        return certificateOfClearance;
      case 'Document/Request under review':
        return documentRequestUnderReview;
      case 'Document(s) being reviewed':
        return documentsBeingReviewed;
      case 'Under process':
        return underProcess;
      case 'Registration request under process':
        return registrationRequestUnderProcess;
      case 'Waiting for Payment':
        return waitingForPayment;
      case 'Cancelled':
        return cancelled;
      case 'Closed':
        return closed;
      case 'Waiting for document(s)':
        return waitingForDocuments;
      case 'Pending':
        return pending;
      case 'Update Document':
        return updateDocument;
      case 'Waiting for additional details':
        return waitingForAdditionalDetails;
      case 'Waiting for FieldActivity Completion':
        return waitingForFieldActivityCompletion;
      case 'Waiting for approval':
        return waitingForApproval;
      case 'Rejected':
        return rejected;
      default:
        return error;
    }
  }

  String get toText {
    switch (value) {
      case 'Active':
        return 'Active';
      case 'Connected':
        return 'Connected';
      case 'Disconnected':
        return 'Disconnected';
      case 'InActive':
        return 'InActive';
      case 'Request under review':
        return 'Request under review';
      case 'Certificate of Clearance':
        return 'Certificate of Clearance';
      case 'Document/Request under review':
        return 'Document/Request under review';
      case 'Document(s) being reviewed':
        return 'Document(s) being reviewed';
      case 'Under process':
        return 'Under process';
      case 'Registration request under process':
        return 'Registration request under process';
      case 'Waiting for Payment':
        return 'Waiting for Payment';
      case 'Cancelled':
        return 'Cancelled';
      case 'Closed':
        return 'Closed';
      case 'Waiting for document(s)':
        return 'Waiting for document(s)';
      case 'Pending':
        return 'Pending';
      case 'Update Document':
        return 'Update Document';
      case 'Waiting for additional details':
        return 'Waiting for additional details';
      case 'Waiting for FieldActivity Completion':
        return 'Waiting for FieldActivity Completion';
      case 'Waiting for approval':
        return 'Waiting for approval';
      case 'Rejected':
        return 'Rejected';
      default:
        return '';
    }
  }

  Color get toTextColor {
    switch (value) {
      case 'Active':
      case 'Connected':
        return Palette.greenStatusText;
      case 'Request under review':
      case 'Certificate of Clearance':
      case 'Document/Request under review':
      case 'Update Document':
      case 'Waiting for additional details':
      case 'Waiting for FieldActivity Completion':
      case 'Waiting for approval':
      case 'Waiting for document(s)':
      case 'Document(s) being reviewed':
      case 'Under process':
      case 'Registration request under process':
        return Palette.blueStatusText;
      case 'Waiting for Payment':
      case 'Pending':
        return Palette.yellowStatusText;
      case 'InActive':
      case 'Cancelled':
      case 'Closed':
      case 'Rejected':
      case 'Disconnected':
        return Palette.redStatusText;
      default:
        return Palette.blackTextColor;
    }
  }

  Color get toBgColor {
    switch (value) {
      case 'Active':
      case 'Connected':
        return Palette.greenStatusBg;
      case 'Request under review':
      case 'Certificate of Clearance':
      case 'Document/Request under review':
      case 'Update Document':
      case 'Waiting for additional details':
      case 'Waiting for FieldActivity Completion':
      case 'Waiting for approval':
      case 'Waiting for document(s)':
      case 'Document(s) being reviewed':
      case 'Under process':
      case 'Registration request under process':
        return Palette.blueStatusBg;
      case 'Waiting for Payment':
      case 'Pending':
        return Palette.yellowStatusBg;
      case 'InActive':
      case 'Cancelled':
      case 'Closed':
      case 'Rejected':
      case 'Disconnected':
        return Palette.redStatusBg;
      default:
        return Palette.greyTextColorLight.withOpacity(0.2);
    }
  }
}
