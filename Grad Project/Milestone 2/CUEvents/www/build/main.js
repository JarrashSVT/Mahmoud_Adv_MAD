webpackJsonp([1],{

/***/ 101:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return FirebaseProvider; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_angularfire2_database__ = __webpack_require__(189);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


/*
  Generated class for the FirebaseProvider provider.

  See https://angular.io/guide/dependency-injection for more info on providers
  and Angular DI.
*/
var FirebaseProvider = (function () {
    function FirebaseProvider(db) {
        this.db = db;
        console.log('Hello FirebaseProvider Provider');
    }
    FirebaseProvider.prototype.getEvents = function () {
        return this.db.list('events').valueChanges();
    };
    // addEvent(eventTitle)
    // {
    //   this.db.list('events').push({'title': eventTitle})
    // }
    FirebaseProvider.prototype.addEvent = function (values) {
        console.log(JSON.stringify(values));
        // this.db.list('events').push({'title': values})
        this.db.list('events').push({
            'title': values.title,
            'desc': values.desc,
            'startdate': values.startdate,
            'enddate': values.enddate,
            'starttime': values.starttime,
            'endtime': values.endtime,
            'address': values.address,
            'publicorreg': values.publicorreg,
            'cat': values.catid,
            'target': values.targetid,
            'city': values.cityid
        });
    };
    FirebaseProvider.prototype.getCategories = function () {
        return this.db.list('categories').valueChanges();
    };
    FirebaseProvider.prototype.getCities = function () {
        return this.db.list('cities').valueChanges();
    };
    FirebaseProvider.prototype.getAudience = function () {
        return this.db.list('audience').valueChanges();
    };
    FirebaseProvider = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["A" /* Injectable */])(),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_angularfire2_database__["a" /* AngularFireDatabase */]])
    ], FirebaseProvider);
    return FirebaseProvider;
}());

//# sourceMappingURL=firebase.js.map

/***/ }),

/***/ 133:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AddEventsPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(37);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__angular_forms__ = __webpack_require__(23);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__providers_firebase_firebase__ = __webpack_require__(101);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




/**
 *
 * Generated class for the AddEventsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */
var AddEventsPage = (function () {
    function AddEventsPage(navCtrl, navParams, formBuilder, firebaseProvider) {
        this.navCtrl = navCtrl;
        this.navParams = navParams;
        this.firebaseProvider = firebaseProvider;
        this.categories = this.firebaseProvider.getCategories();
        this.audience = this.firebaseProvider.getAudience();
        this.cities = this.firebaseProvider.getCities();
        this.postForm = formBuilder.group({
            title: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            desc: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            startdate: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            enddate: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            starttime: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            endtime: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            address: [
                ''
            ],
            publicorreg: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            catid: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            targetid: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ],
            cityid: [
                '',
                __WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].compose([__WEBPACK_IMPORTED_MODULE_2__angular_forms__["f" /* Validators */].required])
            ]
        });
    }
    AddEventsPage.prototype.grow = function ($event) {
        $event.target.style.height = $event.target.scrollHeight + "px";
    };
    AddEventsPage.prototype.ionViewDidLoad = function () {
        console.log('ionViewDidLoad AddEventsPage');
    };
    AddEventsPage.prototype.submit = function () {
        this.firebaseProvider.addEvent(this.postForm.value);
    };
    AddEventsPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-add-events',template:/*ion-inline-start:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/add-events/add-events.html"*/'<!--\n  Generated template for the AddEventsPage page.\n\n  See http://ionicframework.com/docs/components/#navigation for more info on\n  Ionic pages and navigation.\n-->\n<ion-header mode="md">\n  <ion-navbar mode="md">\n    <ion-title style="text-align:center" mode="md">\n     New Event\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n\n<ion-content class="adv-content">\n  <form [formGroup]="postForm">\n    <ion-item>\n      <ion-label class="input-title" stacked>Event Title </ion-label>\n      <ion-label color="danger" class="input-error" stacked\n      *ngIf="!postForm.controls.title.valid && postForm.controls.title.dirty">\n        <ion-icon name="ios-alert"></ion-icon>\n        Please enter a title\n      </ion-label>\n      <ion-input formControlName="title" type="text"></ion-input>\n    </ion-item>\n\n    <ion-item>\n      <ion-label class="input-title" stacked>Event Description</ion-label>\n      <ion-label color="danger" class="input-error" stacked\n      *ngIf="!postForm.controls.desc.valid && postForm.controls.desc.dirty">\n        <ion-icon name="ios-alert"></ion-icon>\n        الرجاء ادخال الوصف\n      </ion-label>\n      <ion-textarea rows="4" placeholder="" formControlName="desc" (keyup)="grow($event)" (keydown)="grow($event)" type="text"></ion-textarea>\n    </ion-item>\n\n    <ion-item>\n      <ion-label class="input-title" stacked>Address</ion-label>\n      <ion-input formControlName="address" type="text"></ion-input>\n    </ion-item>\n\n    <ion-item no-lines>\n      <ion-label class="input-title" stacked>Event Timing</ion-label>\n      \n    <ion-row item-content style="width: 100%;">\n      <ion-col>\n        <ion-label text-center no-padding no-margin stacked>Date</ion-label>\n        <ion-item>\n          <ion-note item-start>From</ion-note>\n          <ion-datetime [min]="mindate" [max]="maxdate" cancelText="Cancel" doneText="Done" displayFormat="DD/MM/YYYY" formControlName="startdate"></ion-datetime>\n        </ion-item>\n        <ion-item>\n          <ion-note item-start>To</ion-note>\n          <ion-datetime [min]="mindate" [max]="maxdate" cancelText="Cancel" doneText="Done" displayFormat="DD/MM/YYYY" formControlName="enddate"></ion-datetime>\n        </ion-item>\n      </ion-col>\n      <ion-col>\n        <ion-label text-center no-padding no-margin stacked>Time</ion-label>\n        <ion-item>\n          <ion-note item-start>From</ion-note>\n          <ion-datetime cancelText="Cancel" doneText="Done" displayFormat="hh:mm a" formControlName="starttime"></ion-datetime>\n        </ion-item>\n        <ion-item>\n          <ion-note item-start>To</ion-note>\n          <ion-datetime cancelText="Cancel" doneText="Done" displayFormat="hh:mm a" formControlName="endtime"></ion-datetime>\n        </ion-item>\n      </ion-col>\n    </ion-row>\n  </ion-item>\n    <ion-item no-lines>\n      <ion-label class="input-title" stacked>Registration</ion-label>\n      <ion-label color="danger" class="input-error" stacked\n      *ngIf="!postForm.controls.title.valid && postForm.controls.title.dirty">\n        <ion-icon name="ios-alert"></ion-icon>\n        Please select the Registration requirement\n      </ion-label>\n    </ion-item>\n    <div padding-horizontal>\n      <ion-segment padding-horizontal mode="ios" formControlName="publicorreg" dir="ltr">\n        <ion-segment-button value="Required">\n          Required\n        </ion-segment-button>\n        <ion-segment-button value="Not Required">\n          Not Required\n        </ion-segment-button>\n      </ion-segment>\n\n\n</div>\n      \n      <ion-item no-lines>\n        <ion-label class="input-title" stacked>Event Specs</ion-label>\n      <ion-row item-content style="width: 100%;">\n        <ion-col>\n          <ion-item text-center no-padding>\n            <ion-label no-margin no-padding stacked text-center>Event Category</ion-label>\n            <ion-select no-padding cancelText="Cancel" okText="OK" formControlName="catid">\n              <ion-option no-padding *ngFor="let cat of categories | async" [value]="cat.cat_name">{{cat.cat_name}}</ion-option>\n            </ion-select>\n          </ion-item>\n        </ion-col>\n        <ion-col>\n          <ion-item text-center no-padding>\n            <ion-label text-center no-padding no-margin stacked>Tergeted Audience</ion-label>\n            <ion-select no-padding cancelText="Cancel" okText="OK" formControlName="targetid">\n              <ion-option no-padding *ngFor="let target of audience | async" [value]="target.name">{{target.name}}</ion-option>\n            </ion-select>\n          </ion-item>\n        </ion-col>\n        <ion-col>\n          <ion-item text-center no-padding>\n            <ion-label text-center no-padding no-margin stacked>City</ion-label>\n            <ion-select no-padding cancelText="Cancel" okText="OK"  formControlName="cityid">\n              <ion-option no-padding *ngFor="let city of cities | async" [value]="city.name">{{city.name}}</ion-option>\n            </ion-select>\n          </ion-item>\n        </ion-col>\n      </ion-row>\n</ion-item>\n\n\n\n \n  \n\n\n\n  </form>\n\n  <button color="twitter"  mode="md" ion-button full (click)="submit()">\n    Add Event \n  </button>\n</ion-content>\n'/*ion-inline-end:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/add-events/add-events.html"*/,
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["e" /* NavController */], __WEBPACK_IMPORTED_MODULE_1_ionic_angular__["f" /* NavParams */], __WEBPACK_IMPORTED_MODULE_2__angular_forms__["a" /* FormBuilder */], __WEBPACK_IMPORTED_MODULE_3__providers_firebase_firebase__["a" /* FirebaseProvider */]])
    ], AddEventsPage);
    return AddEventsPage;
}());

//# sourceMappingURL=add-events.js.map

/***/ }),

/***/ 145:
/***/ (function(module, exports) {

function webpackEmptyAsyncContext(req) {
	// Here Promise.resolve().then() is used instead of new Promise() to prevent
	// uncatched exception popping up in devtools
	return Promise.resolve().then(function() {
		throw new Error("Cannot find module '" + req + "'.");
	});
}
webpackEmptyAsyncContext.keys = function() { return []; };
webpackEmptyAsyncContext.resolve = webpackEmptyAsyncContext;
module.exports = webpackEmptyAsyncContext;
webpackEmptyAsyncContext.id = 145;

/***/ }),

/***/ 188:
/***/ (function(module, exports, __webpack_require__) {

var map = {
	"../pages/add-events/add-events.module": [
		442,
		0
	]
};
function webpackAsyncContext(req) {
	var ids = map[req];
	if(!ids)
		return Promise.reject(new Error("Cannot find module '" + req + "'."));
	return __webpack_require__.e(ids[1]).then(function() {
		return __webpack_require__(ids[0]);
	});
};
webpackAsyncContext.keys = function webpackAsyncContextKeys() {
	return Object.keys(map);
};
webpackAsyncContext.id = 188;
module.exports = webpackAsyncContext;

/***/ }),

/***/ 279:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return TabsPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__contact_contact__ = __webpack_require__(280);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__home_home__ = __webpack_require__(281);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__add_events_add_events__ = __webpack_require__(133);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};




var TabsPage = (function () {
    function TabsPage() {
        this.tab1Root = __WEBPACK_IMPORTED_MODULE_2__home_home__["a" /* HomePage */];
        this.tab2Root = __WEBPACK_IMPORTED_MODULE_3__add_events_add_events__["a" /* AddEventsPage */];
        this.tab3Root = __WEBPACK_IMPORTED_MODULE_1__contact_contact__["a" /* ContactPage */];
    }
    TabsPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({template:/*ion-inline-start:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/tabs/tabs.html"*/'<ion-tabs>\n  <ion-tab [root]="tab1Root" tabTitle="Home" tabIcon="home"></ion-tab>\n  <ion-tab [root]="tab2Root" tabTitle="Add Events" tabIcon="information-circle"></ion-tab>\n  <ion-tab [root]="tab3Root" tabTitle="Contact" tabIcon="contacts"></ion-tab>\n</ion-tabs>\n'/*ion-inline-end:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/tabs/tabs.html"*/
        }),
        __metadata("design:paramtypes", [])
    ], TabsPage);
    return TabsPage;
}());

//# sourceMappingURL=tabs.js.map

/***/ }),

/***/ 280:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return ContactPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(37);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


var ContactPage = (function () {
    function ContactPage(navCtrl) {
        this.navCtrl = navCtrl;
    }
    ContactPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-contact',template:/*ion-inline-start:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/contact/contact.html"*/'<ion-header>\n  <ion-navbar>\n    <ion-title>\n      Contact\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n<ion-content>\n  <ion-list>\n    <ion-list-header>Follow us on Twitter</ion-list-header>\n    <ion-item>\n      <ion-icon name="ionic" item-start></ion-icon>\n      @ionicframework\n    </ion-item>\n  </ion-list>\n</ion-content>\n'/*ion-inline-end:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/contact/contact.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["e" /* NavController */]])
    ], ContactPage);
    return ContactPage;
}());

//# sourceMappingURL=contact.js.map

/***/ }),

/***/ 281:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return HomePage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(37);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__providers_firebase_firebase__ = __webpack_require__(101);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


// import { AngularFireDatabase } from 'angularfire2/database'

var HomePage = (function () {
    function HomePage(navCtrl, firebaseProvider) {
        this.navCtrl = navCtrl;
        this.firebaseProvider = firebaseProvider;
        console.log('constructor');
        //this.events = db.list('events').valueChanges();
        this.events = this.firebaseProvider.getEvents();
        this.categories = this.firebaseProvider.getCategories();
    }
    HomePage.prototype.addEvent = function () {
        this.firebaseProvider.addEvent(this.newEvent);
    };
    HomePage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-home',template:/*ion-inline-start:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/home/home.html"*/'<ion-header>\n  <ion-navbar color="primary">\n    <ion-title>\n      CU Events\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n \n<ion-content>\n  <ion-row>\n    <ion-col col-9>\n      <ion-item>\n        <ion-input type="text" [(ngModel)]="newEvent" placeholder="New Event"></ion-input>\n      </ion-item>\n    </ion-col>\n    <ion-col>\n      <button ion-button (click)="addEvent()">Add!</button>\n    </ion-col>\n  </ion-row>\n \n  <ion-list>\n    <ion-item-sliding *ngFor="let event of events | async">\n      <ion-item>\n        {{ event.title }}\n      </ion-item>\n      <ion-item-options side="right">\n        <button ion-button color="danger" icon-only (click)="removeItem(item.$key)"><ion-icon name="trash"></ion-icon></button>\n      </ion-item-options>\n    </ion-item-sliding>\n  </ion-list>\n\n  <ion-list>\n    <ion-item-sliding *ngFor="let cat of categories | async">\n      <ion-item>\n        {{ cat.cat_name }}\n      </ion-item>\n    </ion-item-sliding>\n  </ion-list>\n</ion-content>'/*ion-inline-end:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/home/home.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["e" /* NavController */], __WEBPACK_IMPORTED_MODULE_2__providers_firebase_firebase__["a" /* FirebaseProvider */]])
    ], HomePage);
    return HomePage;
}());

//# sourceMappingURL=home.js.map

/***/ }),

/***/ 283:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_platform_browser_dynamic__ = __webpack_require__(284);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__app_module__ = __webpack_require__(304);


Object(__WEBPACK_IMPORTED_MODULE_0__angular_platform_browser_dynamic__["a" /* platformBrowserDynamic */])().bootstrapModule(__WEBPACK_IMPORTED_MODULE_1__app_module__["a" /* AppModule */]);
//# sourceMappingURL=main.js.map

/***/ }),

/***/ 304:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* unused harmony export firebaseConfig */
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AppModule; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__angular_platform_browser__ = __webpack_require__(39);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_ionic_angular__ = __webpack_require__(37);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__app_component__ = __webpack_require__(427);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_about_about__ = __webpack_require__(436);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__pages_contact_contact__ = __webpack_require__(280);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__pages_home_home__ = __webpack_require__(281);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__pages_tabs_tabs__ = __webpack_require__(279);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__pages_add_events_add_events__ = __webpack_require__(133);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9_angularfire2__ = __webpack_require__(41);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10_angularfire2_database__ = __webpack_require__(189);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11_angularfire2_auth__ = __webpack_require__(437);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__ionic_native_status_bar__ = __webpack_require__(275);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_13__ionic_native_splash_screen__ = __webpack_require__(278);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_14__providers_firebase_firebase__ = __webpack_require__(101);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};









// Import the AF2 Module






var firebaseConfig = {
    apiKey: "AIzaSyDhd_icst9w2RyJ_56tn0-myEDF1DhppFg",
    authDomain: "cuevents-ionic.firebaseapp.com",
    databaseURL: "https://cuevents-ionic.firebaseio.com",
    projectId: "cuevents-ionic",
    storageBucket: "",
    messagingSenderId: "968116707569"
};
var AppModule = (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["I" /* NgModule */])({
            declarations: [
                __WEBPACK_IMPORTED_MODULE_3__app_component__["a" /* MyApp */],
                __WEBPACK_IMPORTED_MODULE_4__pages_about_about__["a" /* AboutPage */],
                __WEBPACK_IMPORTED_MODULE_5__pages_contact_contact__["a" /* ContactPage */],
                __WEBPACK_IMPORTED_MODULE_6__pages_home_home__["a" /* HomePage */],
                __WEBPACK_IMPORTED_MODULE_7__pages_tabs_tabs__["a" /* TabsPage */],
                __WEBPACK_IMPORTED_MODULE_8__pages_add_events_add_events__["a" /* AddEventsPage */]
            ],
            imports: [
                __WEBPACK_IMPORTED_MODULE_1__angular_platform_browser__["a" /* BrowserModule */],
                __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["c" /* IonicModule */].forRoot(__WEBPACK_IMPORTED_MODULE_3__app_component__["a" /* MyApp */], {}, {
                    links: [
                        { loadChildren: '../pages/add-events/add-events.module#AddEventsPageModule', name: 'AddEventsPage', segment: 'add-events', priority: 'low', defaultHistory: [] }
                    ]
                }),
                __WEBPACK_IMPORTED_MODULE_9_angularfire2__["a" /* AngularFireModule */].initializeApp(firebaseConfig),
                __WEBPACK_IMPORTED_MODULE_10_angularfire2_database__["b" /* AngularFireDatabaseModule */],
                __WEBPACK_IMPORTED_MODULE_11_angularfire2_auth__["a" /* AngularFireAuthModule */]
            ],
            bootstrap: [__WEBPACK_IMPORTED_MODULE_2_ionic_angular__["a" /* IonicApp */]],
            entryComponents: [
                __WEBPACK_IMPORTED_MODULE_3__app_component__["a" /* MyApp */],
                __WEBPACK_IMPORTED_MODULE_4__pages_about_about__["a" /* AboutPage */],
                __WEBPACK_IMPORTED_MODULE_5__pages_contact_contact__["a" /* ContactPage */],
                __WEBPACK_IMPORTED_MODULE_6__pages_home_home__["a" /* HomePage */],
                __WEBPACK_IMPORTED_MODULE_7__pages_tabs_tabs__["a" /* TabsPage */],
                __WEBPACK_IMPORTED_MODULE_8__pages_add_events_add_events__["a" /* AddEventsPage */]
            ],
            providers: [
                __WEBPACK_IMPORTED_MODULE_12__ionic_native_status_bar__["a" /* StatusBar */],
                __WEBPACK_IMPORTED_MODULE_13__ionic_native_splash_screen__["a" /* SplashScreen */],
                { provide: __WEBPACK_IMPORTED_MODULE_0__angular_core__["u" /* ErrorHandler */], useClass: __WEBPACK_IMPORTED_MODULE_2_ionic_angular__["b" /* IonicErrorHandler */] },
                __WEBPACK_IMPORTED_MODULE_10_angularfire2_database__["a" /* AngularFireDatabase */],
                __WEBPACK_IMPORTED_MODULE_14__providers_firebase_firebase__["a" /* FirebaseProvider */]
            ]
        })
    ], AppModule);
    return AppModule;
}());

//# sourceMappingURL=app.module.js.map

/***/ }),

/***/ 427:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return MyApp; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(37);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__ionic_native_status_bar__ = __webpack_require__(275);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__ionic_native_splash_screen__ = __webpack_require__(278);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__pages_tabs_tabs__ = __webpack_require__(279);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};





var MyApp = (function () {
    function MyApp(platform, statusBar, splashScreen) {
        this.rootPage = __WEBPACK_IMPORTED_MODULE_4__pages_tabs_tabs__["a" /* TabsPage */];
        platform.ready().then(function () {
            // Okay, so the platform is ready and our plugins are available.
            // Here you can do any higher level native things you might need.
            statusBar.styleDefault();
            splashScreen.hide();
        });
    }
    MyApp = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({template:/*ion-inline-start:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/app/app.html"*/'<ion-nav [root]="rootPage"></ion-nav>\n'/*ion-inline-end:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/app/app.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["g" /* Platform */], __WEBPACK_IMPORTED_MODULE_2__ionic_native_status_bar__["a" /* StatusBar */], __WEBPACK_IMPORTED_MODULE_3__ionic_native_splash_screen__["a" /* SplashScreen */]])
    ], MyApp);
    return MyApp;
}());

//# sourceMappingURL=app.component.js.map

/***/ }),

/***/ 436:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AboutPage; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__angular_core__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_ionic_angular__ = __webpack_require__(37);
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};


var AboutPage = (function () {
    function AboutPage(navCtrl) {
        this.navCtrl = navCtrl;
    }
    AboutPage = __decorate([
        Object(__WEBPACK_IMPORTED_MODULE_0__angular_core__["m" /* Component */])({
            selector: 'page-about',template:/*ion-inline-start:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/about/about.html"*/'<ion-header>\n  <ion-navbar>\n    <ion-title>\n      About\n    </ion-title>\n  </ion-navbar>\n</ion-header>\n\n<ion-content padding>\n\n</ion-content>\n'/*ion-inline-end:"/Users/mahmoud/Documents/ionicFramework/CUEvents/src/pages/about/about.html"*/
        }),
        __metadata("design:paramtypes", [__WEBPACK_IMPORTED_MODULE_1_ionic_angular__["e" /* NavController */]])
    ], AboutPage);
    return AboutPage;
}());

//# sourceMappingURL=about.js.map

/***/ })

},[283]);
//# sourceMappingURL=main.js.map