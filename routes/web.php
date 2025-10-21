<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\FacilityController;
use App\Http\Controllers\QualityControlController;
use App\Http\Controllers\AuditQuestionController;
use App\Http\Controllers\AuditAreaCategoryController;
use App\Http\Controllers\AvsecOfficersController;
use App\Http\Controllers\CertificationsController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\PersonnelController;
use App\Http\Controllers\QualificationsController;
use App\Http\Controllers\SecurityConcernsController;
use App\Http\Controllers\SecurityEquipmentController;
use App\Http\Controllers\TrainingController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\FollowupController;
use App\Http\Controllers\QualityControlReportController;
use App\Http\Controllers\DepartmentsController;
use App\Http\Controllers\MandatoryCourseController;
use App\Http\Controllers\SpecialisedTrainingController;
use App\Http\Controllers\ProtocolQuestionsController;
use App\Http\Controllers\LogsController;

use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
})->name('welcome');



Route::get('/errors', function () {
    return Inertia::render('Errors/ErrorPage', [
        'message' => session('error') ?? 'Something went wrong.'
    ]);
})->name('errors');

Route::middleware(['auth','verified'])->group(function () {

    Route::get('/dashboard', [DashboardController::class,'index'])->name('dashboard');

    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');    
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    
    //Training  Route
    Route::get('/training', function () {
        return Inertia::render('Training');
    })->name('training');
    

    // Excel Download template and bulk save import
    Route::post('/protocolquestions/importProtocol', [ProtocolQuestionsController::class, 'importProtocolQuestions'])->name('protocolquestions.importProtocol');
    Route::get('/protocolquestions/template', [ProtocolQuestionsController::class, 'downloadTemplate'])->name('protocolquestions.template');


    //Permission Routes
    Route::get('/permissions', [PermissionController::class, 'index'])->name('permissions.index');
    Route::get('/permissions/create', [PermissionController::class, 'create'])->name('permissions.create');
    Route::post('/permissions', [PermissionController::class, 'store'])->name('permissions.store');
    Route::get('/permissions/{id}/edit', [PermissionController::class, 'edit'])->name('permissions.edit');
    Route::post('/permissions/{id}', [PermissionController::class, 'update'])->name('permissions.update');
    Route::delete('/permissions/{id}', [PermissionController::class, 'destroy'])->name('permissions.destroy');

    //Permission Roles
    Route::get('/roles', [RoleController::class, 'index'])->name('roles.index');
    Route::get('/roles/create', [RoleController::class, 'create'])->name('roles.create');
    Route::post('/roles', [RoleController::class, 'store'])->name('roles.store');
    Route::get('/roles/{id}/edit', [RoleController::class, 'edit'])->name('roles.edit');
    Route::post('/roles/{id}', [RoleController::class, 'update'])->name('roles.update');
    Route::delete('/roles/{id}', [RoleController::class, 'destroy'])->name('roles.destroy');

    //User Routes
    Route::get('/users', [UserController::class, 'index'])->name('users.index');
    Route::get('/users/create', [UserController::class, 'create'])->name('users.create');
    Route::post('/users', [UserController::class, 'store'])->name('users.store');
    Route::get('/users/{id}/edit', [UserController::class, 'edit'])->name('users.edit');
    Route::post('/users/{id}', [UserController::class, 'update'])->name('users.update');
    Route::delete('/users/{id}', [UserController::class, 'destroy'])->name('users.destroy');


    //Facility Routes
    Route::get('/facilities', [FacilityController::class, 'index'])->name('facilities.index');
    Route::get('/facilities/create', [FacilityController::class, 'create'])->name('facilities.create');
    Route::post('/facilities', [FacilityController::class, 'store'])->name('facilities.store');
    Route::get('/facilities/{id}/edit', [FacilityController::class, 'edit'])->name('facilities.edit');
    Route::post('/facilities/{id}', [FacilityController::class, 'update'])->name('facilities.update');
    Route::delete('/facilities/{id}', [FacilityController::class, 'destroy'])->name('facilities.destroy');
    Route::get('/facilities/{id}/show', [FacilityController::class, 'show'])->name('facilities.show');
    Route::get('/api/facilities/downloadFacilities', [FacilityController::class, 'downloadOperatorsPDF'])->name('facilities.downloadOperatorsPDF');

    //Quality Control Routes
    Route::get('/quality-controls', [QualityControlController::class, 'index'])->name('quality-controls.index');
    Route::get('/quality-controls/create', [QualityControlController::class, 'create'])->name('quality-controls.create');
    Route::post('/quality-controls', [QualityControlController::class, 'store'])->name('quality-controls.store');
    Route::get('/quality-controls/{id}/edit', [QualityControlController::class, 'edit'])->name('quality-controls.edit');
    Route::post('/quality-controls/{id}', [QualityControlController::class, 'update'])->name('quality-controls.update');
    Route::delete('/quality-controls/{id}', [QualityControlController::class, 'destroy'])->name('quality-controls.destroy');
    Route::get('/quality-controls/{id}/show', [QualityControlController::class, 'show'])->name('quality-controls.show');
    Route::post('/quality-controls/{id}/saveQuestionResponse', [QualityControlController::class, 'saveQuestionResponse'])->name('quality-controls.saveQuestionResponse');

    Route::get('quality-controls/audits', [QualityControlController::class, 'listAudits'])->name('quality-controls.listAudits');
    Route::get('quality-controls/inspections', [QualityControlController::class, 'listInspections'])->name('quality-controls.listInspections');
    Route::get('quality-controls/securityTests', [QualityControlController::class, 'listSecurityTests'])->name('quality-controls.listSecurityTests');
    Route::get('quality-controls/pending', [QualityControlController::class, 'listPending'])->name('quality-controls.listPending');
    Route::get('quality-controls/inprogress', [QualityControlController::class, 'listInProgress'])->name('quality-controls.listInProgress');
    Route::get('quality-controls/completed', [QualityControlController::class, 'listCompleted'])->name('quality-controls.listCompleted');
    Route::get('quality-controls/overdue', [QualityControlController::class, 'listOverdue'])->name('quality-controls.listOverdue');
    Route::post('/quality-controls/{id}/approve', [QualityControlController::class, 'approveQualityControl'])->name('quality-controls.approve');



    //Audit Question Routes
    Route::get('/audit-questions', [AuditQuestionController::class, 'index'])->name('audit-questions.index'); 
    Route::get('/audit-questions/create', [AuditQuestionController::class, 'create'])->name('audit-questions.create');
    Route::post('/audit-questions', [AuditQuestionController::class, 'store'])->name('audit-questions.store');
    Route::get('/audit-questions/{id}/edit', [AuditQuestionController::class, 'edit'])->name('audit-questions.edit');
    Route::post('/audit-questions/{id}', [AuditQuestionController::class, 'update'])->name('audit-questions.update');
    Route::delete('/audit-questions/{id}', [AuditQuestionController::class, 'destroy'])->name('audit-questions.destroy');

    

    //Audit Area Category Routes
    Route::get('/audit-categories', [AuditAreaCategoryController::class, 'index'])->name('audit-categories.index');
    Route::get('/audit-categories/create', [AuditAreaCategoryController::class, 'create'])->name('audit-categories.create');
    Route::post('/audit-categories', [AuditAreaCategoryController::class, 'store'])->name('audit-categories.store');
    Route::get('/audit-categories/{id}/edit', [AuditAreaCategoryController::class, 'edit'])->name('audit-categories.edit');
    Route::post('/audit-categories/{id}', [AuditAreaCategoryController::class, 'update'])->name('audit-categories.update');
    Route::delete('/audit-categories/{id}', [AuditAreaCategoryController::class, 'destroy'])->name('audit-categories.destroy');

    //Audit Question Routes
    Route::get('/audit-questions', [AuditQuestionController::class, 'index'])->name('audit-questions.index');
    Route::get('/audit-questions/create', [AuditQuestionController::class, 'create'])->name('audit-questions.create');
    Route::post('/audit-questions', [AuditQuestionController::class, 'store'])->name('audit-questions.store');
    Route::get('/audit-questions/{id}/edit', [AuditQuestionController::class, 'edit'])->name('audit-questions.edit');
    Route::post('/audit-questions/{id}', [AuditQuestionController::class, 'update'])->name('audit-questions.update');
    Route::delete('/audit-questions/{id}', [AuditQuestionController::class, 'destroy'])->name('audit-questions.destroy');

    //Security-Equipment Routes
    Route::get('/security-equipments', [SecurityEquipmentController::class, 'index'])->name('security-equipments.index');
    Route::get('/security-equipments/create', [SecurityEquipmentController::class, 'create'])->name('security-equipments.create');
    Route::post('/security-equipments', [SecurityEquipmentController::class, 'store'])->name('security-equipments.store');
    Route::get('/security-equipments/{id}/edit', [SecurityEquipmentController::class, 'edit'])->name('security-equipments.edit');
    Route::get('/security-equipments/{id}/createSchedule', [SecurityEquipmentController::class, 'createSchedule'])->name('security-equipments.createSchedule');
    Route::post('/security-equipments/storeSchedule', [SecurityEquipmentController::class, 'storeSchedule'])->name('security-equipments.storeSchedule');    
    Route::post('/security-equipments/{id}', [SecurityEquipmentController::class, 'update'])->name('security-equipments.update');
    Route::delete('/security-equipments/{id}', [SecurityEquipmentController::class, 'destroy'])->name('security-equipments.destroy');
    Route::delete('/security-equipments/deleteMaintenanceSchedule/{id}', [SecurityEquipmentController::class, 'deleteMaintenanceSchedule'])->name('security-equipments.deleteMaintenanceSchedule');
    

    Route::get('/security-equipments/{id}/editSchedule', [SecurityEquipmentController::class, 'editSchedule'])->name('security-equipments.editSchedule');
    Route::post('/security-equipments/schedule/{id}', [SecurityEquipmentController::class, 'updateSchedule'])->name('security-equipments.updateSchedule');


    //Training Routes
    Route::get('/trainings', [TrainingController::class, 'index'])->name('trainings.index');
    Route::get('/trainings/create', [TrainingController::class, 'create'])->name('trainings.create');
    Route::post('/trainings', [TrainingController::class, 'store'])->name('trainings.store');
    Route::get('/trainings/{id}/edit', [TrainingController::class, 'edit'])->name('trainings.edit');
    Route::post('/trainings/{id}', [TrainingController::class, 'update'])->name('trainings.update');
    Route::delete('/trainings/{id}', [TrainingController::class, 'destroy'])->name('trainings.destroy');        

    //Personnel Training Routes
    Route::get('/personnels', [PersonnelController::class, 'index'])->name('personnels.index');
    Route::get('/personnels/create', [PersonnelController::class, 'create'])->name('personnels.create');
    Route::post('/personnels', [PersonnelController::class, 'store'])->name('personnels.store');
    Route::get('/personnels/{id}/edit', [PersonnelController::class, 'edit'])->name('personnels.edit');
    Route::post('/personnels/{id}', [PersonnelController::class, 'update'])->name('personnels.update');
    Route::get('/personnels/{id}/show', [PersonnelController::class, 'show'])->name('personnels.show');
    Route::delete('/personnels/{id}', [PersonnelController::class, 'destroy'])->name('personnels.destroy');    
    
    //Certifcations Route
    Route::get('/personnels/{id}/certifications/create', [CertificationsController::class, 'create'])->name('certifications.create');
    Route::post('/personnels/{id}/certifications', [CertificationsController::class, 'store'])->name('certifications.store');
    Route::get('/certifications/{id}/edit', [CertificationsController::class, 'edit'])->name('certifications.edit');
    Route::post('/certifications/{id}', [CertificationsController::class, 'update'])->name('certifications.update');
    Route::delete('/certifications/{id}', [CertificationsController::class, 'destroy'])->name('certifications.destroy');    
    
    //Certification Routes
    Route::get('/personnels/{id}/qualifications/create', [QualificationsController::class, 'create'])->name('qualifications.create');
    Route::post('/personnels/{id}/qualifications', [QualificationsController::class, 'store'])->name('qualifications.store');
    Route::get('/qualifications/{id}/edit', [QualificationsController::class, 'edit'])->name('qualifications.edit');
    Route::post('/qualifications/{id}', [QualificationsController::class, 'update'])->name('qualifications.update');
    Route::delete('/qualifications/{id}', [QualificationsController::class, 'destroy'])->name('qualifications.destroy');        


     //Security Concerns Routes
    Route::get('/securityconcerns', [SecurityConcernsController::class, 'index'])->name('securityconcerns.index');
    Route::get('/securityconcerns/{id}/edit', [SecurityConcernsController::class, 'edit'])->name('securityconcerns.edit');
    Route::post('/securityconcerns/{id}', [SecurityConcernsController::class, 'update'])->name('securityconcerns.update');
    Route::get('/api/securityconcerns/{id}/generateCar', [SecurityConcernsController::class, 'generateCar'])->name('securityconcerns.generateCar');


    //Sidebar Routes
    Route::get('/securityconcerns/count', [SecurityConcernsController::class, 'securityConcernsCount'])->name('securityconcerns.api.index');


    //Dashboard Routes
    Route::get('/dashboard/stats', [DashboardController::class, 'getDashboardStats'])->name('getDashboardStats');

    //Followup Routes
    Route::get('/followups/{id}/create', [FollowupController::class, 'create'])->name('followups.create');
    Route::get('/followups/{id}/edit', [FollowupController::class, 'edit'])->name('followups.edit');
    Route::post('/followups/{id}/followups', [FollowupController::class, 'store'])->name('followups.store');    
    Route::post('/followups/{id}/update', [FollowupController::class, 'update'])->name('followups.update');
    Route::delete('/followups/{id}', [FollowupController::class, 'destroy'])->name('followups.destroy');        


    //Quality Control Report Routes
    Route::get('/quality-control-reports', [QualityControlReportController::class, 'index'])->name('quality-control-reports.index');
    Route::get('/api/quality-control-reports/{id}/generateQualityControlReport', [QualityControlReportController::class, 'generateQualityControlReport'])->name('quality-control-reports.generateQualityControlReport');

    //Department Routes
    Route::get('/departments', [DepartmentsController::class, 'index'])->name('departments.index');
    Route::get('/departments/create', [DepartmentsController::class, 'create'])->name('departments.create');
    Route::post('/departments', [DepartmentsController::class, 'store'])->name('departments.store');
    Route::get('/departments/{id}/edit', [DepartmentsController::class, 'edit'])->name('departments.edit');
    Route::post('/departments/{id}', [DepartmentsController::class, 'update'])->name('departments.update');
    Route::delete('/departments/{id}', [DepartmentsController::class, 'destroy'])->name('departments.destroy');

    //Two Factor Authentication
    Route::post('/users/disable2fa/{id}', [UserController::class, 'disable2fa'])->name('users.disable2fa');

    // Export PDF Route
    Route::post('/dashboard/export-pdf', [DashboardController::class, 'exportPdf'])->name('dashboard.exportPdf');
    Route::get('/facilities/{id}/download-pdf', [FacilityController::class, 'downloadPdf'])->name('facilities.downloadPdf');
    Route::get('/personnels/{id}/download', [PersonnelController::class, 'downloadPersonnelPDF'])->name('personnels.download');
    Route::get('/quality-controls/{id}/export-pdf', [QualityControlController::class, 'exportPDF'])->name('quality-controls.exportPDF');
        
    //Officers Training Routes
    Route::get('/officers', [AvsecOfficersController::class, 'index'])->name('officers.index');
    Route::get('/officers/create', [AvsecOfficersController::class, 'create'])->name('officers.create');
    Route::post('/officers', [AvsecOfficersController::class, 'store'])->name('officers.store');
    Route::get('/officers/{id}/show', [AvsecOfficersController::class, 'show'])->name('officers.show');
    Route::get('/officers/{id}/edit', [AvsecOfficersController::class, 'edit'])->name('officers.edit');
    Route::post('/officers/{id}', [AvsecOfficersController::class, 'update'])->name('officers.update');
    Route::delete('/officers/{id}', [AvsecOfficersController::class, 'destroy'])->name('officers.destroy');    
    
    //Mandatory course Routes
    Route::get('/personnels/{id}/mandatorycourses/create', [MandatoryCourseController::class, 'create'])->name('mandatorycourses.create');
    Route::post('/mandatorycourses/store', [MandatoryCourseController::class, 'store'])->name('mandatorycourses.store');
    Route::delete('/officers/{id}', [MandatoryCourseController::class, 'destroy'])->name('mandatorycourses.destroy');    
    Route::get('/mandatorycourses/{id}/edit', [MandatoryCourseController::class, 'edit'])->name('mandatorycourses.edit');
    Route::post('/mandatorycourses/{id}', [MandatoryCourseController::class, 'update'])->name('mandatorycourses.update');

    //specialised trainig routes
    Route::get('/personnels/{id}/specialisedtrainings/create', [SpecialisedTrainingController::class, 'create'])->name('specialisedtrainings.create');
    Route::post('/specialisedtrainings/store', [SpecialisedTrainingController::class, 'store'])->name('specialisedtrainings.store');
    Route::delete('/specialisedtrainings/{id}', [SpecialisedTrainingController::class, 'destroy'])->name('specialisedtrainings.destroy');
    Route::get('/specialisedtrainings/{id}/edit', [SpecialisedTrainingController::class, 'edit'])->name('specialisedtrainings.edit');
    Route::post('/specialisedtrainings/{id}', [SpecialisedTrainingController::class, 'update'])->name('specialisedtrainings.update');
    Route::get('/officers/{id}/download', [MandatoryCourseController::class, 'downloadStaffPDF'])->name('officers.download');
    Route::get('/quality-controls/{id}/export-pdf', [QualityControlController::class, 'exportPDF'])->name('quality-controls.exportPDF');

    //Protocol Questions Routes
    //Facility Routes
    Route::get('/protocolquestions', [ProtocolQuestionsController::class, 'index'])->name('protocolquestions.index');
    Route::get('/protocolquestions/create', [ProtocolQuestionsController::class, 'create'])->name('protocolquestions.create');
    Route::post('/protocolquestions', [ProtocolQuestionsController::class, 'store'])->name('protocolquestions.store');
    Route::get('/protocolquestions/{id}/edit', [ProtocolQuestionsController::class, 'edit'])->name('protocolquestions.edit');
    Route::post('/protocolquestions/{id}', [ProtocolQuestionsController::class, 'update'])->name('protocolquestions.update');
    Route::delete('/protocolquestions/{id}', [ProtocolQuestionsController::class, 'destroy'])->name('protocolquestions.destroy');
    Route::get('/protocolquestions/{id}/show', [ProtocolQuestionsController::class, 'show'])->name('protocolquestions.show');    
    Route::get('/protocolquestions/{id}/createReference', [ProtocolQuestionsController::class, 'createReference'])->name('protocolquestions.createReference');
    Route::post('/protocolquestions/{id}/storeReference', [ProtocolQuestionsController::class, 'storeReference'])->name('protocolquestions.storeReference');
    Route::get('/protocolquestions/{id}/editReference', [ProtocolQuestionsController::class, 'editReference'])->name('protocolquestions.editReference');
    Route::post('/protocolquestions/{id}/updateReference', [ProtocolQuestionsController::class, 'updateReference'])->name('protocolquestions.updateReference');
    Route::delete('/protocolquestions/{id}/destroyReferenceDocument', [ProtocolQuestionsController::class, 'destroyReferenceDocument'])->name('protocolquestions.destroyReferenceDocument');

    Route::get('/protocolquestions/{id}/createEvidence', [ProtocolQuestionsController::class, 'createEvidence'])->name('protocolquestions.createEvidence');
    Route::post('/protocolquestions/{id}/storeEvidence', [ProtocolQuestionsController::class, 'storeEvidence'])->name('protocolquestions.storeEvidence');
    Route::get('/protocolquestions/{id}/editEvidence', [ProtocolQuestionsController::class, 'editEvidence'])->name('protocolquestions.editEvidence');
    Route::post('/protocolquestions/{id}/updateEvidence', [ProtocolQuestionsController::class, 'updateEvidence'])->name('protocolquestions.updateEvidence');
    Route::delete('/protocolquestions/{id}/destroyEvidenceDocument', [ProtocolQuestionsController::class, 'destroyEvidenceDocument'])->name('protocolquestions.destroyEvidenceDocument');
    Route::get('/quality-controls/{id}/export-pdf', [QualityControlController::class, 'exportPDF'])->name('quality-controls.exportPDF');


    Route::get('/protocolquestions', [ProtocolQuestionsController::class, 'index'])->name('protocolquestions.index');
    Route::get('/protocolquestions/create', [ProtocolQuestionsController::class, 'create'])->name('protocolquestions.create');
    Route::post('/protocolquestions', [ProtocolQuestionsController::class, 'store'])->name('protocolquestions.store');
    Route::get('/protocolquestions/{id}/edit', [ProtocolQuestionsController::class, 'edit'])->name('protocolquestions.edit');
    Route::post('/protocolquestions/{id}', [ProtocolQuestionsController::class, 'update'])->name('protocolquestions.update');
    Route::delete('/protocolquestions/{id}', [ProtocolQuestionsController::class, 'destroy'])->name('protocolquestions.destroy');
    Route::get('/protocolquestions/{id}/show', [ProtocolQuestionsController::class, 'show'])->name('protocolquestions.show');    
    Route::get('/protocolquestions/{id}/createReference', [ProtocolQuestionsController::class, 'createReference'])->name('protocolquestions.createReference');
    Route::post('/protocolquestions/{id}/storeReference', [ProtocolQuestionsController::class, 'storeReference'])->name('protocolquestions.storeReference');
    Route::get('/protocolquestions/{id}/editReference', [ProtocolQuestionsController::class, 'editReference'])->name('protocolquestions.editReference');
    Route::post('/protocolquestions/{id}/updateReference', [ProtocolQuestionsController::class, 'updateReference'])->name('protocolquestions.updateReference');
    Route::delete('/protocolquestions/{id}/destroyReferenceDocument', [ProtocolQuestionsController::class, 'destroyReferenceDocument'])->name('protocolquestions.destroyReferenceDocument');

    Route::get('/protocolquestions/{id}/createEvidence', [ProtocolQuestionsController::class, 'createEvidence'])->name('protocolquestions.createEvidence');
    Route::post('/protocolquestions/{id}/storeEvidence', [ProtocolQuestionsController::class, 'storeEvidence'])->name('protocolquestions.storeEvidence');
    Route::get('/protocolquestions/{id}/editEvidence', [ProtocolQuestionsController::class, 'editEvidence'])->name('protocolquestions.editEvidence');
    Route::post('/protocolquestions/{id}/updateEvidence', [ProtocolQuestionsController::class, 'updateEvidence'])->name('protocolquestions.updateEvidence');
    Route::delete('/protocolquestions/{id}/destroyEvidenceDocument', [ProtocolQuestionsController::class, 'destroyEvidenceDocument'])->name('protocolquestions.destroyEvidenceDocument');
    Route::get('/protocolquestions/export/pdf', [ProtocolQuestionsController::class, 'exportPDF'])->name('protocolquestions.export.pdf');

    //Logs Routes
    Route::get('/logs', [LogsController::class, 'index'])->name('logs.index');
    Route::delete('/logs/clear', [LogsController::class, 'clearLogs'])->name('logs.clear');
});



    //Interface routes
    Route::get('about-us', function () {
            return Inertia::render('Site/AboutUs');
    })->name('aboutPage');

    Route::get('contact-us', function () {
        return Inertia::render('Site/ContactUs');
    })->name('contactPage');

    Route::post('/contacts', [ContactController::class, 'store']);
    Route::get('/contacts', [ContactController::class, 'fetchAllContacts']);


        




























//require __DIR__.'/auth.php';
