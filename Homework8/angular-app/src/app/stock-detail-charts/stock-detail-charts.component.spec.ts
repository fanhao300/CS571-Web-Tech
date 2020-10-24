import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockDetailChartsComponent } from './stock-detail-charts.component';

describe('StockDetailChartsComponent', () => {
  let component: StockDetailChartsComponent;
  let fixture: ComponentFixture<StockDetailChartsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StockDetailChartsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StockDetailChartsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
