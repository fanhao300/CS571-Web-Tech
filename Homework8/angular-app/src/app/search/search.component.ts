import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {
  ticker = new FormControl('');
  
  constructor(
    private router: Router) {}

  ngOnInit(): void {
  }
  

  btnClick() {
    this.router.navigateByUrl('/detail/' + this.ticker.value);
};

}
