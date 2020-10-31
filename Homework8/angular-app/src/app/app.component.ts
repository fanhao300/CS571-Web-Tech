import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  constructor() {}

  title = 'Stock Search';

  ngOnInit() {
    if (localStorage.getItem("portfolio") == null){
      localStorage.setItem("portfolio","[]");
    }

    if (localStorage.getItem("watchList") == null){
      localStorage.setItem("watchList","");
    }
  }
}
