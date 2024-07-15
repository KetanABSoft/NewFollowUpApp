
import 'package:followup/controller/employee_controller.dart';
import 'package:get/get.dart';
import '../controller/admin_controller/admin_add_lead_controller.dart';
import '../controller/admin_controller/admin_add_task_controller.dart';
import '../controller/admin_controller/admin_calculate_salary_contoller.dart';
import '../controller/admin_controller/admin_dashboard_controller.dart';
import '../controller/admin_controller/admin_lead_list_controller.dart';
import '../controller/admin_controller/admin_overdue_controller.dart';
import '../controller/admin_controller/admin_pending_controller.dart';
import '../controller/admin_controller/admin_send_task_controller.dart';
import '../controller/admin_controller/admin_set_wages_controller.dart';
import '../controller/admin_controller/admin_task_completed_controller.dart';
import '../controller/admin_controller/admin_timesheet_controller.dart';
import '../controller/admin_controller/admin_todays_task_controller.dart';
import '../controller/admin_controller/admin_total_task_controller.dart';
import '../controller/admin_controller/admin_view_task_controller.dart';
import '../controller/emp_controller/emp_add_task_controller.dart';
import '../controller/emp_controller/emp_create_lead_controller.dart';
import '../controller/emp_controller/emp_dashboard_controller.dart';
import '../controller/emp_controller/emp_edit_task_controller.dart';
import '../controller/emp_controller/emp_lead_list_controller.dart';
import '../controller/emp_controller/emp_send_task_controller.dart';
import '../controller/emp_controller/emp_task_complete_controller.dart';
import '../controller/emp_controller/emp_task_overdue_controller.dart';
import '../controller/emp_controller/emp_task_recieve_controller.dart';
import '../controller/emp_controller/emp_task_pending_controller.dart';
import '../controller/emp_controller/emp_total_task_list_controller.dart';
import '../controller/emp_controller/emp_view_task_controller.dart';
import '../controller/login_controller.dart';

class EmpAddTaskBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpAddTaskController());
  }
}

class EmpAddLeadBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpCreateLeadController());
  }
}

class EmpDashBoardBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpDashBoardController());
  }
}

// class EditRecorderBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => EditRecorderController());
//   }
// }

class EmpEditTaskBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpEditTaskController());
  }
}

class EmpLeadListBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpLeadListController());
  }
}

class EmpTotalTaskListBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpTotalTaskListController());
  }
}

class LoginBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => LoginBinding());
  }
}

// class NotificationServiceBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => NotificationServiceController());
//   }
// }

// class NotificationScreenBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => NotificationScreenController());
//   }
// }

class EmpOverdueTaskBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpTaskOverdueController());
  }
}

// class PageTransitionBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => PageTransitionController());
//   }
// }

// class ProfileBinding extends Bindings
// {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => ProfileController());
//   }
// }

// class RecorderBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => RecorderController());
//   }
// }

// class RemarkBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => RemarkController());
//   }
// }

class EmpTaskCompletedBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => EmpTaskController());
  }
}

class AdminTaskCompletedBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => AdminTaskCompletedController());
  }
}

class EmpTaskPendingBinding extends Bindings
{
  @override
  void dependencies() {
  Get.lazyPut(() => EmpTaskPendingController());
  }
}

class EmpTaskRecieveBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpTaskRecieveController());
  }
}

class EmpTaskSendBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => EmpSendTaskController());
  }
}

// class ViewNotificationBinding extends Bindings
// {
//   @override
//   void dependencies() {
//    Get.lazyPut(() => ViewNotificationController());
//   }
// }

class AdminViewTaskBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => AdminViewTaskController());
  }
}

class EmpViewTaskBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => EmpViewTaskController());
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
  }
}

class AdminAddLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddLead>(() => AdminAddLead());
  }
}

class AdminAddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddTaskController>(() => AdminAddTaskController());
  }
}

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardController>(() => AdminDashboardController());
  }
}

class AdminLeadListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminLeadListController>(() => AdminLeadListController());
  }
}

class AdminOverdueTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminOverdueController>(() => AdminOverdueController());
  }
}

class AdminPendingTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPendingController>(() => AdminPendingController());
  }
}

class AdminTimesheethTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminTimesheetController>(() => AdminTimesheetController());
  }
}

class AdminTotalTaskTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminTotalTaskController>(() => AdminTotalTaskController());
  }
}

class AdminCalculateSalaryTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalculateSalaryController>(() => CalculateSalaryController());
  }
}


class AdminSetWagesTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSetWagesController>(() => AdminSetWagesController());
  }
}

class AdminSendTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSendTaskController>(() => AdminSendTaskController());
  }
}


class AdminTodaysTaskTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminTodaysTaskController>(() => AdminTodaysTaskController());
  }
}