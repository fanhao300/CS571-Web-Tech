import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockDetailSummaryComponent } from './stock-detail-summary.component';

describe('StockDetailSummaryComponent', () => {
  let component: StockDetailSummaryComponent;
  let fixture: ComponentFixture<StockDetailSummaryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StockDetailSummaryComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StockDetailSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
