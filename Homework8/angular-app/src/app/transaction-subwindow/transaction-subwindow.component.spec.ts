import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransactionSubwindowComponent } from './transaction-subwindow.component';

describe('TransactionSubwindowComponent', () => {
  let component: TransactionSubwindowComponent;
  let fixture: ComponentFixture<TransactionSubwindowComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TransactionSubwindowComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TransactionSubwindowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
