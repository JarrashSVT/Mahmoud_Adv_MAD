import { NgModule, ErrorHandler } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { MyApp } from './app.component';

import { AboutPage } from '../pages/about/about';
import { ContactPage } from '../pages/contact/contact';
import { HomePage } from '../pages/home/home';
import { TabsPage } from '../pages/tabs/tabs';
import { AddEventsPage } from '../pages/add-events/add-events'
import { EventDatailsPage} from '../pages/event-datails/event-datails'
import { SharePopoverPage } from '../pages/share-popover/share-popover' 

// Import the AF2 Module
import { AngularFireModule} from 'angularfire2'
import { AngularFireDatabaseModule, AngularFireDatabase} from 'angularfire2/database'
import { AngularFireAuthModule } from 'angularfire2/auth';

import { StatusBar } from '@ionic-native/status-bar';
import { SplashScreen } from '@ionic-native/splash-screen';
import { FirebaseProvider } from '../providers/firebase/firebase';

export const firebaseConfig = {
  apiKey: "AIzaSyDhd_icst9w2RyJ_56tn0-myEDF1DhppFg",
  authDomain: "cuevents-ionic.firebaseapp.com",
  databaseURL: "https://cuevents-ionic.firebaseio.com",
  projectId: "cuevents-ionic",
  storageBucket: "",
  messagingSenderId: "968116707569"
};

@NgModule({
  declarations: [
    MyApp,
    AboutPage,
    ContactPage,
    HomePage,
    TabsPage,
    AddEventsPage,
    EventDatailsPage,
    SharePopoverPage
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(MyApp),
    AngularFireModule.initializeApp(firebaseConfig),
    AngularFireDatabaseModule,
    AngularFireAuthModule
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    AboutPage,
    ContactPage,
    HomePage,
    TabsPage,
    AddEventsPage,
    EventDatailsPage,
    SharePopoverPage
  ],
  providers: [
    StatusBar,
    SplashScreen,
    {provide: ErrorHandler, useClass: IonicErrorHandler},
    AngularFireDatabase,
    FirebaseProvider
  ]
})
export class AppModule {}
