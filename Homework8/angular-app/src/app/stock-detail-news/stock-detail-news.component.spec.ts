import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StockDetailNewsComponent } from './stock-detail-news.component';

describe('StockDetailNewsComponent', () => {
  let component: StockDetailNewsComponent;
  let fixture: ComponentFixture<StockDetailNewsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StockDetailNewsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StockDetailNewsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
