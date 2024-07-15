import 'package:followup/binding/app_binding.dart';
import 'package:followup/routes/route.dart';
import 'package:followup/screens/add_update_employee_screen.dart';
import 'package:followup/screens/employee_screen.dart';
import 'package:followup/screens/subcription_screen.dart';
import 'package:followup/screens/success_screen.dart';
import 'package:get/get.dart';
import '../employee/emp_add_task_screen.dart';
import '../employee/emp_lead_list_screen.dart';
import '../employee/emp_overdue_task.dart';
import '../employee/emp_task_completed_screen.dart';
import '../employee/emp_task_recieve_screen.dart';
import '../admin/admin_add_lead.dart';
import '../admin/admin_add_task.dart';
import '../admin/admin_dashboard.dart';
import '../admin/admin_lead_list.dart';
import '../admin/admin_overdue_task.dart';
import '../admin/admin_pending_task.dart';
import '../admin/admin_send_task.dart';
import '../admin/admin_task_completed.dart';
import '../admin/admin_view_task.dart';
import '../employee/emp_task_send_screen.dart';
import '../employee/emp_task_pending_screen.dart';
import '../employee/emp_view_task_screen.dart';
import '../employee/emp_create_lead_screen.dart';
import '../employee/emp_dashboard_screen.dart';
import '../loginscreen.dart';


class AppPages
{
  static String INITIAL_ROUTE = Routes.LOGIN_SCREEN_ROUTE;

  static final Pages =
  [
    GetPage(
        name: Routes.LOGIN_SCREEN_ROUTE,
        page: () => LoginScreen(),
        binding:AuthBinding()
    ),
    GetPage(
        name: Routes.ADMIN_ADD_TASK_ROUTE,
        page: () => AdminAddTask(audioPath: ""),
        binding:AdminAddTaskBinding()
    ),
    GetPage(
        name: Routes.EMP_ADD_TASK_ROUTE,
        page: () => EmployeeAddTask(audioPath: ""),
        binding:EmpAddTaskBinding()
    ),
    GetPage(
        name: Routes.ADMIN_CREATE_LEAD_ROUTE,
        page: () => AdminAddLead(id: '', task: '',),
        binding:AdminAddLeadBinding()
    ),
    GetPage(
        name: Routes.EMP_CREATE_LEAD_ROUTE,
        page: () => EmpCreateLead(id: '', task: '',),
        binding:EmpAddLeadBinding()
    ),
    GetPage(
        name: Routes.ADMIN_DASHBOARD_ROUTE,
        page: () => AdminDashboardScreen(),
        binding:AdminDashboardBinding()
    ),
    GetPage(
        name: Routes.EMP_DASHBOARD_ROUTE,
        page: () => EmpDashboardScreen(),
        binding:EmpDashBoardBinding()
    ),
    // GetPage(
    //     name: Routes.EDIT_RECORD_ROUTE,
    //     page: () => EditRecord(id: '', task: '',),
    //     binding:EditRecorderBinding()
    // ),
    // GetPage(
    //     name: Routes.EDIT_TASK_ROUTE,
    //     page: () => Edit(id: '', task: '', audiopath: '', backto: '',),
    //     binding:EditTaskBinding()
    // ),
    GetPage(
        name: Routes.ADMIN_LEAD_LIST_ROUTE,
        page: () => AdminLeadList(),
        binding:AdminLeadListBinding()
    ),
    GetPage(
        name: Routes.EMP_LEAD_LIST_ROUTE,
        page: () => EmpLeadList(),
        binding:EmpLeadListBinding()
    ),

    // GetPage(
    //     name: Routes.LIST_ALL_ROUTE,
    //     page: () => TotalTask(admin_type: '',),
    //     binding:ListAllBinding()
    // ),

    // GetPage(
    //     name: Routes.NOTIFICATION_SCREEN_ROUTE,
    //     page: () => TotalTask(admin_type: '',),
    //     binding:NotificationScreenBinding()
    // ),

    GetPage(
        name: Routes.ADMIN_OVERDUE_TASK_ROUTE,
        page: () => AdminOverdueTask(admin_type: '',),
        binding:AdminOverdueTaskBinding()
    ),
    GetPage(
        name: Routes.EMP_OVERDUE_TASK_ROUTE,
        page: () => EmpOverdueTask(admin_type: '',),
        binding:AdminOverdueTaskBinding()
    ),
    // GetPage(
    //     name: Routes.PROFILE_ROUTE,
    //     page: () => Profile(),
    //     binding:ProfileBinding()
    // ),
    // GetPage(
    //     name: Routes.RECORDER_ROUTE,
    //     page: () => MyApp(),
    //     binding:RecorderBinding()
    // ),
    // GetPage(
    //     name: Routes.REMARK_ROUTE,
    //     page: () => Remark(id: '',),
    //     binding:RemarkBinding()
    // ),
    GetPage(
        name: Routes.ADMIN_TASK_COMPLETED_ROUTE,
        page: () => AdminTaskCompleteScreen(),
        binding:AdminTaskCompletedBinding()
    ),
    GetPage(
        name: Routes.EMP_TASK_COMPLETED_ROUTE,
        page: () => EmpTaskCompletedScreen(),
        binding:EmpTaskCompletedBinding()
    ),
    GetPage(
        name: Routes.ADMIN_PENDING_ROUTE,
        page: () => AdminTaskincompleted(),
        binding:AdminPendingTaskBinding()
    ),
    GetPage(
        name: Routes.EMP_PENDING_ROUTE,
        page: () => EmpTaskPending(),
        binding:EmpTaskPendingBinding()
    ),
    GetPage(
        name: Routes.EMP_TASK_RECEIEVE_ROUTE,
        page: () => EmpReceiveTask(),
        binding:EmpTaskRecieveBinding()
    ),
    GetPage(
        name: Routes.ADMIN_TASK_SEND_ROUTE,
        page: () => AdminSendTaskScreen(),
        binding:AdminSendTaskBinding()
    ),
    GetPage(
        name: Routes.EMP_TASK_SEND_ROUTE,
        page: () => EmployeeSendTask(),
        binding:EmpTaskSendBinding()
    ),
    // GetPage(
    //     name: Routes.TEST_ROUTE,
    //     page: () => TimerPage(),
    //     binding:TestBindings()
    // ),
    // GetPage(
    //     name: Routes.VIEW_NOTIFICATION_ROUTE,
    //     page: () => Viewnotification(id: '',),
    //     binding:ViewNotificationBinding()
    // ),
    GetPage(
        name: Routes.EMP_VIEW_TASK_ROUTE,
        page: () => Viewtask(id: '',),
        binding:EmpViewTaskBinding()
    ),
    GetPage(
        name: Routes.ADMIN_VIEW_TASK_ROUTE,
        page: () => AdminViewTaskScreen(admin_type: '',),
        binding:AdminViewTaskBinding()
    ),
    GetPage(
        name: Routes.SUBSCRIPTION_SCREEN,
        page: () => SubscriptionScreen(),
        binding: AuthBinding()
    ),
    GetPage(
        name: Routes.SUCCESS_SCREEN,
        page: () => SuccessScreen(),
    ),
    GetPage(
        name: Routes.ADD_UPDATE_EMPLOYEE_SCREEN,
        page: () => AddUpdateEmployeeScreen(),
        binding: EmployeeBinding()
    ),
    GetPage(
        name: Routes.EMPLOYEE_SCREEN,
        page: () => EmployeeScreen(),
        binding: EmployeeBinding()
    ),

  ];
}