import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockDetailNewsSubwindowComponent } from './stock-detail-news-subwindow.component';

describe('StockDetailNewsSubwindowComponent', () => {
  let component: StockDetailNewsSubwindowComponent;
  let fixture: ComponentFixture<StockDetailNewsSubwindowComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StockDetailNewsSubwindowComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StockDetailNewsSubwindowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
