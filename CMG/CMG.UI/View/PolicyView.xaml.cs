using CMG.Application.ViewModel;
using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Threading;
using CMG.Application.DTO;
using CMG.UI.Controls;
using System.Linq;
using System.Collections.ObjectModel;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using ToastNotifications.Messages;
using System.Collections.Generic;
using CMG.UI.Converter;

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for PolicyView.xaml
    /// </summary>
    public partial class PolicyView : UserControl
    {
        #region Member variables
        private PolicyViewModel policyViewModel;
        private ContextMenu ctxMenu;
        private ContextMenu illustrationContextMenu;
        private MenuItem menuItem;
        private MenuItem IllustrationMenuItem;

        private const string ColumnNamePolicyNumber = "Policy Number";
        private const string ColumnNameCompany = "Company";
        private const string ColumnNameFaceAmount = "Face Amount";
        private const string ColumnNamePayment = "Payment";
        private const string ColumnNameStatus = "Status";
        private const string ColumnNameFrequency = "Frequency";
        private const string ColumnNameType = "Type";
        private const string ColumnNamePlanCode = "Plan Code";
        private const string ColumnNameRating = "Rating";
        private const string ColumnNameClass = "Class";
        private const string ColumnNameCurrency = "Currency";
        private const string ColumnNamePolicyDate = "Policy Date";
        private const string ColumnNamePlacedOn = "Placed On";
        private const string ColumnNameReprojectedOn = "Reprojected On";
        private const string ColumnNameAge = "Age";
        private const string ColumnNamePolicyNotes = "Policy Notes";
        private const string ColumnNameClientNotes = "Client Notes";
        private const string ColumnNameInternalNotes = "Internal Notes";
        private const string ColumnNameBeneficiary = "Beneficiary";
        private const string ColumnNameInsured = "Insured";
        private const string ColumnNameOwner = "Owner";

        private const string ColumnNameYear = "Year";
        private const string ColumnNameAD = "Annual Deposit";
        private const string ColumnNameADA = "Annual Deposit Actual";
        private const string ColumnNameADR = "Annual Deposit Reprojection";
        private const string ColumnNameCV = "Cash Value";
        private const string ColumnNameCVA = "Cash Value Actual";
        private const string ColumnNameCVR = "Cash Value Reprojection";
        private const string ColumnNameDB = "Death Benefit";
        private const string ColumnNameDBA = "Death Benefit Actual";
        private const string ColumnNameDBR = "Death Benefit Reprojection";
        private const string ColumnNameACB = "Adjusted Costbase";
        private const string ColumnNameACBA = "Adjusted Costbase Actual";
        private const string ColumnNameACBR = "Adjusted Costbase Reprojection";
        private const string ColumnNameNCPI = "NCPI";
        private const string ColumnNameNCPIA = "NCPI Actual";
        private const string ColumnNameNCPIR = "NCPI Reprojection";

        private const string AddColumns = "Add Columns";
        private const string Remove = "Remove";

        private const string BindingPolicyNumner = "PolicyNumber";
        private const string BindingCompanyName  = "CompanyName";
        private const string BindingFaceAmount = "FaceAmount";
        private const string BindingPayment = "Payment";
        private const string BindingStatus = "Status";
        private const string BindingFrequency = "Frequency";
        private const string BindingType = "Type";
        private const string BindingPlanCode = "PlanCode";
        private const string BindingRating = "Rating";
        private const string BindingClass = "Class";
        private const string BindingCurrency = "Currency";
        private const string BindingPolicyDate = "PolicyDate";
        private const string BindingPlacedOn = "PlacedOn";
        private const string BindingReprojectedOn = "ReprojectedOn";
        private const string BindingAge = "Age";
        private const string BindingPolicyNotes = "PolicyNotes";
        private const string BindingClientNotes = "ClientNotes";
        private const string BindingInternalNotes = "InternalNotes";
        private const string BindingBeneficiary = "Beneficiary";
        private const string BindingInsured = "Insured";
        private const string BindingOwner = "Owner";
        private const string GridNamePolicies = "policies";
        private const string GridNameIllustration = "illustration";

        private const string BindingYear = "Year";
        private const string BindingAD = "AnnualDeposit";
        private const string BindingADA = "AnnualDepositActual";
        private const string BindingADR = "AnnualDepositReprojection";
        private const string BindingCV = "CashValue";
        private const string BindingCVA = "CashValueActual";
        private const string BindingCVR = "CashValueReprojection";
        private const string BindingDB = "DeathBenefit";
        private const string BindingDBA = "DeathBenefitActual";
        private const string BindingDBR = "DeathBenefitReprojection";
        private const string BindingACB = "AdjustedCostBase";
        private const string BindingACBA = "AdjustedCostBaseActual";
        private const string BindingACBR = "AdjustedCostBaseReprojection";
        private const string BindingNCPI = "NCPI";
        private const string BindingNCPIA = "NCPIActual";
        private const string BindingNCPIR = "NCPIReprojection";
        #endregion

        #region Constructor
        public PolicyView()
        {
            InitializeComponent();
            Dispatcher.BeginInvoke(DispatcherPriority.Loaded, new Action(() =>
            {
                if (policyViewModel == null)
                {
                    policyViewModel = (PolicyViewModel)this.DataContext;
                }
            }));
        }
        #endregion Constructor

        #region Events
        private void ButtonSearchSliderClose_Click(object sender, RoutedEventArgs e)
        {

            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(550) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                SearchSliderColumn.Width = new GridLength(0);
                SearchBar.Visibility = Visibility.Visible;
                searchBarColumn.Width = new GridLength(200);
            };
        }
        private void ButtonSearchSliderOpen_Click(object sender, RoutedEventArgs e)
        {
            SearchBar.Visibility = Visibility.Collapsed;
            SearchSliderColumn.Width = new GridLength(450);
            searchBarColumn.Width = new GridLength(0);
        }
        private void ButtonIllustrationOpen_Click(object sender, RoutedEventArgs e)
        {
            IllustrationSliderPanel.Visibility = Visibility.Visible;
            PolicyEdit.Visibility = Visibility.Collapsed;
            PolicyMainView.Opacity = 0.3;
        }
        private void ButtonIllustrationClose_Click(object sender, RoutedEventArgs e)
        {
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(600) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                IllustrationSliderPanel.Visibility = Visibility.Collapsed;
                PolicyMainView.Opacity = 0.9;
            };
        }
        private void ButtonIllustrationEditOpen_Click(object sender, RoutedEventArgs e)
        {
            IllustrationEdit.Visibility = Visibility.Visible;
            IllustrationEdit.Width = IllustrationSliderPanel.ActualWidth - 300;
            IllustrationSliderPanel.Opacity = 0.6;
            PolicyMainView.Opacity = 0.05;
        }
        private void ButtonIllustrationEditClose_Click(object sender, RoutedEventArgs e)
        {
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(700) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                IllustrationEdit.Visibility = Visibility.Collapsed;
                IllustrationSliderPanel.Opacity = 1;
                PolicyMainView.Opacity = 0.3;
            };
        }
        private void ButtonPolicyEditOpen_Click(object sender, RoutedEventArgs e)
        {
            PolicyEdit.Visibility = Visibility.Visible;
            PolicyEdit.Width = 700;
            PolicyMainView.Opacity = 0.05;
            string value = string.Empty;
            UserControlPlanCode.autoTextBox.Text = policyViewModel?.SelectedPolicy?.PlanCode;
            UserControlClass.autoTextBox.Text = policyViewModel?.SelectedPolicy?.Class;
            UserControlRating.autoTextBox.Text = policyViewModel?.SelectedPolicy?.Rating;
            SetAutomCompleteStyle(UserControlPlanCode);
            SetAutomCompleteStyle(UserControlClass);
            SetAutomCompleteStyle(UserControlRating);
        }
        private void ButtonPolicyEditClose_Click(object sender, RoutedEventArgs e)
        {
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(600) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                PolicyEdit.Visibility = Visibility.Collapsed;
                PolicyMainView.Opacity = 1;
            };
        }
        private void ButtonAddRelationship_Click(object sender, RoutedEventArgs e)
        {
            AddRelationship.Visibility = Visibility.Visible;
            AddRelationship.Width = 1000;
            PolicyMainView.Opacity = 0.05;
        }
        private void ButtonAddRelationshipClose_Click(object sender, RoutedEventArgs e)
        {
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(600) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                AddRelationship.Visibility = Visibility.Collapsed;
                PolicyMainView.Opacity = 1;
            };
        }
        private void Policies_AutoGeneratedColumns(object sender, EventArgs e)
        {
            ctxMenu = new ContextMenu();
            menuItem = new MenuItem();
            menuItem.Header = AddColumns;
            ctxMenu.Items.Add(menuItem);

            InitializeViewModel();
            foreach (var columns in policyViewModel.ColumnNames)
            {
                var subMenu = new MenuItem();
                subMenu.Header = columns;
                subMenu.Click += SubMenuAddPolicyColumn_Click;

                menuItem.Items.Add(subMenu);
            }

            menuItem = new MenuItem();
            menuItem.Header = Remove;
            menuItem.Click += MenuItemRemoveColumn_Click;

            ctxMenu.Items.Add(menuItem);

            PolicyGridDefaultSetting();
            for (int i = 0; i < policies.Columns.Count; i++)
            {
                ResizeGridColumns(policies.Columns[i].Header.ToString(), GridNamePolicies);
            }
            if(policies.Items.Count > 0)
                policies.SelectedItem = policies.Items[0];
        }
        private void MenuItemRemoveColumn_Click(object sender, RoutedEventArgs e)
        {
            MenuItem selectedMenu = (MenuItem)sender;
            var removeColumnName = selectedMenu.DataContext.ToString();

            if (!string.IsNullOrEmpty(removeColumnName))
            {
                var columnIndex = policies.Columns.IndexOf(policies.Columns.FirstOrDefault(c => c.Header.ToString() == removeColumnName));

                RemovePolicyGridColumn(removeColumnName);
                policyViewModel.PolicyColumns.RemoveAt(columnIndex - 1);
                ResetPolicyColumnsIndex(columnIndex - 1, true);
                policyViewModel.SaveOptionKeyPolicyColumns();
            }
        }
        private void MenuItemRemoveIllustrationColumn_Click(object sender, RoutedEventArgs e)
        {
            MenuItem selectedMenu = (MenuItem)sender;
            TextBlock removeColumnName = (TextBlock)selectedMenu.DataContext;
            if (!string.IsNullOrEmpty(removeColumnName.Text))
            {
                var columnIndex = illustration.Columns.IndexOf(illustration.Columns.FirstOrDefault(c => c.Header is TextBlock && ((TextBlock)c.Header).Text.ToString() == removeColumnName.Text));

                RemoveIllustrationGridColumn(removeColumnName);
                policyViewModel.IllustrationColumns.RemoveAt(columnIndex - 1);
                policyViewModel.IllustrationColumns.ToList().Where(x => x.ColumnOrder >= columnIndex).ToList().ForEach(c => c.ColumnOrder = c.ColumnOrder - 1);
                policyViewModel.SaveOptionKeyIllustrationColumns();
            }
        }
        private void SubMenuAddPolicyColumn_Click(object sender, RoutedEventArgs e)
        {
            MenuItem selectedMenu = (MenuItem)sender;
            var columnIndex = policies.Columns.IndexOf(policies.Columns.FirstOrDefault(c => c.Header.ToString() == selectedMenu.DataContext.ToString()));
            var newColumnName = selectedMenu.Header.ToString();
            var isColumnExist = policies.Columns.Any(x => x.Header.ToString() == newColumnName);
            if (columnIndex == 0)
            {
                columnIndex = 1;
            }
            if (!string.IsNullOrEmpty(newColumnName))
            {
                if (!isColumnExist)
                {
                    policies.Columns.Insert(columnIndex, AddDataGridColumn(newColumnName));
                    for (int i = 0; i < policies.Columns.Count; i++)
                    {
                        ResizeGridColumns(policies.Columns[i].Header.ToString(), GridNamePolicies);
                    }
                    ViewSearchOptionsDto newColumnView = new ViewSearchOptionsDto() { ColumnName = newColumnName, ColumnOrder = columnIndex };
                    ResetPolicyColumnsIndex(columnIndex - 1);
                    policyViewModel.PolicyColumns.Insert(columnIndex - 1, newColumnView);
                    policyViewModel.SaveOptionKeyPolicyColumns();
                }
                else
                {
                    policyViewModel._notifier.ShowError("Column " + newColumnName + " already exists");
                }
            }
        }
        private void SubMenuAddIllustrationColumn_Click(object sender, RoutedEventArgs e)
        {
            MenuItem selectedMenu = (MenuItem)sender;
            int columnIndex = 1;
            if (!string.IsNullOrEmpty(selectedMenu.DataContext.ToString()))
            {
                columnIndex = illustration.Columns.IndexOf(illustration.Columns.FirstOrDefault(c => c.Header is TextBlock && ((TextBlock)c.Header).Text.ToString() == ((TextBlock)selectedMenu.DataContext).Text.ToString()));
            }
            var newColumnName = selectedMenu.Header.ToString();
            var isColumnExist = illustration.Columns.Any(x => x.Header is TextBlock && ((TextBlock)x.Header).Text.ToString() == newColumnName);
            if (!string.IsNullOrEmpty(newColumnName))
            {
                if (!isColumnExist)
                {
                    illustration.Columns.Insert(columnIndex, AddDataGridColumnIllustration(newColumnName));
                    ViewSearchOptionsDto newColumnView = new ViewSearchOptionsDto() { ColumnName = newColumnName, ColumnOrder = columnIndex };
                    ResizeGridColumns(newColumnName, GridNameIllustration);
                    policyViewModel.IllustrationColumns.ToList().Where(x => x.ColumnOrder >= columnIndex).ToList().ForEach(c => c.ColumnOrder = c.ColumnOrder + 1);
                    policyViewModel.IllustrationColumns.Insert(columnIndex - 1, newColumnView);
                    policyViewModel.SaveOptionKeyIllustrationColumns();
                }
                else
                {
                    policyViewModel._notifier.ShowError("Column " + newColumnName + " already exists");
                }
            }
        }
        private void Policies_MouseRightButtonUp(object sender, MouseButtonEventArgs e)
        {
            DependencyObject depObj = (DependencyObject)e.OriginalSource;
            while ((depObj != null) && !(depObj is DataGridColumnHeader))
            {
                depObj = VisualTreeHelper.GetParent(depObj);
            }
            if (depObj == null)
            {
                return;
            }
            if (depObj is DataGridColumnHeader)
            {
                DataGridColumnHeader dgcolHeader = depObj as DataGridColumnHeader;
                dgcolHeader.ContextMenu = ctxMenu;
            }
        }
        private void policies_ColumnReordered(object sender, DataGridColumnEventArgs e)
        {
            if (e.Column is DataGridTextColumn)
            {
                DataGridTextColumn draggedColumn = (DataGridTextColumn)e.Column;
                int droppedColumnIndex = draggedColumn.DisplayIndex;

                ViewSearchOptionsDto vsodto = policyViewModel.PolicyColumns.Where(x => x.ColumnName.ToString().ToLower().Trim() == draggedColumn.Header.ToString().ToLower().Trim()).FirstOrDefault();

                int draggedColumnIndex = policies.Columns.IndexOf(policies.Columns.Where(x => x.Header.ToString() == draggedColumn.Header.ToString()).FirstOrDefault());
                if (draggedColumnIndex > 0
                    && droppedColumnIndex > 0)
                {
                    policyViewModel.PolicyColumns.Remove(vsodto);
                    vsodto.ColumnOrder = droppedColumnIndex;
                    policyViewModel.PolicyColumns.Insert(droppedColumnIndex - 1, vsodto);
                    if (draggedColumnIndex > droppedColumnIndex)
                    {
                        ResetPolicyColumnsIndex(droppedColumnIndex, true);
                    }
                    else
                    {
                        for (int i = droppedColumnIndex - 2; i >= 0; i--)
                        {
                            policyViewModel.PolicyColumns[i].ColumnOrder = i + 1;
                        }
                    }
                    policyViewModel.SaveOptionKeyPolicyColumns();
                    PolicyGridDefaultSetting();
                    for (int i = 0; i < policies.Columns.Count; i++)
                    {
                        ResizeGridColumns(policies.Columns[i].Header.ToString(), GridNamePolicies);
                    }
                }
            }
        }
        private void Illustration_MouseRightButtonUp(object sender, MouseButtonEventArgs e)
        {
            DependencyObject depObj = (DependencyObject)e.OriginalSource;
            while ((depObj != null) && !(depObj is DataGridColumnHeader))
            {
                depObj = VisualTreeHelper.GetParent(depObj);
            }
            if (depObj == null)
            {
                return;
            }
            if (depObj is DataGridColumnHeader)
            {
                DataGridColumnHeader dataGridColumnHeader = depObj as DataGridColumnHeader;
                dataGridColumnHeader.ContextMenu = illustrationContextMenu;
            }
        }
        private void Illustration_AutoGeneratedColumns(object sender, EventArgs e)
        {
            illustrationContextMenu = new ContextMenu();
            IllustrationMenuItem = new MenuItem();
            IllustrationMenuItem.Header = AddColumns;
            illustrationContextMenu.Items.Add(IllustrationMenuItem);
            InitializeViewModel();

            foreach (var columns in policyViewModel.IllustrationColumnNames)
            {
                var subMenu = new MenuItem();
                subMenu.Header = columns;
                subMenu.Click += SubMenuAddIllustrationColumn_Click;

                IllustrationMenuItem.Items.Add(subMenu);
            }
            IllustrationMenuItem = new MenuItem();
            IllustrationMenuItem.Header = Remove;
            IllustrationMenuItem.Click += MenuItemRemoveIllustrationColumn_Click;

            illustrationContextMenu.Items.Add(IllustrationMenuItem);

            IllustrationDefaultSetting();
            for (int i = 0; i < illustration.Columns.Count; i++)
            {
                if (illustration.Columns[i].Header is TextBlock)
                {
                    ResizeGridColumns(((TextBlock)illustration.Columns[i].Header).Text, GridNameIllustration);
                }
            }
            if (illustration.Items.Count > 0)
                illustration.SelectedItem = illustration.Items[0];
        }
        private void Illustration_ColumnReordered(object sender, DataGridColumnEventArgs e)
        {
            if (e.Column is DataGridTextColumn)
            {
                DataGridTextColumn draggedColumn = (DataGridTextColumn)e.Column;
                int droppedColumnIndex = draggedColumn.DisplayIndex;

                ViewSearchOptionsDto vsodto = policyViewModel.IllustrationColumns.Where(x => x.ColumnName.ToString().ToLower().Trim() == ((TextBlock)draggedColumn.Header).Text.ToString().ToLower().Trim()).FirstOrDefault();
                int draggedColumnIndex = illustration.Columns.IndexOf(illustration.Columns.Where(x => x.Header is TextBlock && ((TextBlock)x.Header).Text.ToString() == ((TextBlock)draggedColumn.Header).Text.ToString()).FirstOrDefault());
                if (draggedColumnIndex > 0
                    && droppedColumnIndex > 0)
                {
                    policyViewModel.IllustrationColumns.Remove(vsodto);
                    vsodto.ColumnOrder = droppedColumnIndex;
                    if(draggedColumnIndex > droppedColumnIndex)
                    {
                        policyViewModel.IllustrationColumns.ToList().Where(x => x.ColumnOrder <= draggedColumnIndex && x.ColumnOrder >= droppedColumnIndex).ToList().ForEach(c => c.ColumnOrder = c.ColumnOrder + 1);
                    }
                    else
                    {
                        policyViewModel.IllustrationColumns.ToList().Where(x => x.ColumnOrder >= draggedColumnIndex && x.ColumnOrder <= droppedColumnIndex).ToList().ForEach(c => c.ColumnOrder = c.ColumnOrder - 1);
                    }
                    policyViewModel.IllustrationColumns.Insert(droppedColumnIndex - 1, vsodto);
                    policyViewModel.SaveOptionKeyIllustrationColumns();
                }
                else
                {
                    draggedColumn.CanUserReorder = false;
                    IllustrationDefaultSetting();
                    for (int i = 0; i < illustration.Columns.Count; i++)
                    {
                        if (illustration.Columns[i].Header is TextBlock)
                        {
                            ResizeGridColumns(((TextBlock)illustration.Columns[i].Header).Text, GridNameIllustration);
                        }
                    }
                    if (illustration.Items.Count > 0)
                        illustration.SelectedItem = illustration.Items[0];
                }
            }
        }
        #endregion Events

        #region Methods
        private void ResetPolicyColumnsIndex(int index, bool isRemove = false)
        {
            for (int i = index; i < policyViewModel.PolicyColumns.Count; i++)
            {
                if (!isRemove)
                {
                    policyViewModel.PolicyColumns[i].ColumnOrder = i + 2;
                }
                else
                {
                    policyViewModel.PolicyColumns[i].ColumnOrder = i + 1;
                }
            }
        }
        private void ResizeGridColumns(string columnName, string gridName)
        {
            switch (columnName)
            {
                case ColumnNamePlanCode:
                    SetGridColumnWidth(columnName, 70, gridName);
                    break;
                case ColumnNameCompany:
                    SetGridColumnWidth(columnName, 110, gridName);
                    break;
                case ColumnNameFaceAmount:
                case ColumnNamePayment:
                    SetGridColumnWidth(columnName, 90, gridName);
                    break;
                case ColumnNameFrequency:
                case ColumnNameType:
                case ColumnNameRating:
                case ColumnNameClass:
                case ColumnNameCurrency:
                    SetGridColumnWidth(columnName, 80, gridName);
                    break;
                case ColumnNamePolicyNumber:
                case ColumnNamePolicyDate:
                case ColumnNamePlacedOn:
                case ColumnNameReprojectedOn:
                case ColumnNameStatus:
                case ColumnNameInsured:
                    SetGridColumnWidth(columnName, 100, gridName);
                    break;
                case ColumnNameAge:
                    SetGridColumnWidth(columnName, 50, gridName);
                    break;
                case ColumnNamePolicyNotes:
                case ColumnNameClientNotes:
                case ColumnNameInternalNotes:
                case ColumnNameBeneficiary:
                case ColumnNameOwner:
                    SetGridColumnWidth(columnName, 150, gridName);
                    break;
                case ColumnNameAD:
                case ColumnNameCV:
                case ColumnNameDB:
                case ColumnNameNCPIA:
                case ColumnNameNCPIR:
                    SetGridColumnWidth(columnName, 100, gridName);
                    break;
                case ColumnNameADA:
                case ColumnNameADR:
                case ColumnNameCVA:
                case ColumnNameCVR:
                case ColumnNameDBA:
                case ColumnNameDBR:
                case ColumnNameACB:
                case ColumnNameACBA:
                case ColumnNameACBR:             
                    SetGridColumnWidth(columnName, 130, gridName);
                    break;
                case ColumnNameYear:
                case ColumnNameNCPI:
                    SetGridColumnWidth(columnName, 40, gridName);
                    break;
                default:
                    SetGridColumnWidth(columnName, 0, gridName);
                    break;
            }
        }
        private void SetGridColumnWidth(string columnName, int width, string gridName)
        {
            object dataGridColumn = null;
            switch (gridName)
            {
                case GridNamePolicies:
                    dataGridColumn = policies.Columns.Where(x => x.Header.ToString() == columnName).FirstOrDefault();
                    break;
                case GridNameIllustration:
                    dataGridColumn = illustration.Columns.Where(x => x.Header is TextBlock && ((TextBlock)x.Header).Text.ToString() == columnName).FirstOrDefault();
                    break;
            }
            if (dataGridColumn != null)
            {
                if (width == 0)
                {
                    ((DataGridColumn)dataGridColumn).Width = DataGridLength.Auto;
                }
                else
                {
                    ((DataGridColumn)dataGridColumn).Width = width;
                }
            }
        }
        private void PolicyGridDefaultSetting()
        {
            int totalColumns = policies.Columns.Count;
            for (int i = policies.Columns.Count - 1; i > 0; i--)
            {
                if (i != 0)
                {
                    policies.Columns.RemoveAt(i);
                }
            }

            DefaultPolicyGridColumns(policyViewModel.PolicyColumns.Select(x => x.ColumnName).ToList());
        }
        private void IllustrationDefaultSetting()
        {
            int totalColumns = illustration.Columns.Count;
            for (int i = illustration.Columns.Count - 1; i > 0; i--)
            {
                if (i != 0)
                {
                    illustration.Columns.RemoveAt(i);
                }
            }
            DefaultIllustrationGridColumns(policyViewModel.IllustrationColumns.Select(x => x.ColumnName).ToList());
        }
        private void RemovePolicyGridColumn(string columnName)
        {
            DataGridColumn dataGridColumn = policies.Columns.Where(x => x.Header.ToString() == columnName).FirstOrDefault();
            if (dataGridColumn != null)
                policies.Columns.Remove(dataGridColumn);
        }
        private void RemoveIllustrationGridColumn(TextBlock columnName)
        {
            DataGridColumn dataGridColumn = illustration.Columns.Where(x => x.Header is TextBlock && ((TextBlock)x.Header).Text.ToString() == columnName.Text.ToString()).FirstOrDefault();
            if (dataGridColumn != null)
                illustration.Columns.Remove(dataGridColumn);
        }
        private DataGridColumn AddDataGridColumn(string columnName)
        {
            DataGridTextColumn dataGridColumn = new DataGridTextColumn();
            string bindingPath = string.Empty;
            switch (columnName)
            {
                case ColumnNamePolicyNumber:
                    bindingPath = BindingPolicyNumner;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PolicyNumber = policyViewModel.PolicyCollection[i].PolicyNumber;
                        }
                    }
                    SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameCompany:
                    bindingPath = BindingCompanyName;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].CompanyName = policyViewModel.PolicyCollection[i].CompanyName;
                        }
                    }
                    SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameFaceAmount:
                    bindingPath = BindingFaceAmount;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].FaceAmount = policyViewModel.PolicyCollection[i].FaceAmount;
                        }
                    }
                    SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNamePayment:
                    bindingPath = BindingPayment;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Payment = policyViewModel.PolicyCollection[i].Payment;
                        }
                    }
                    SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameStatus:
                    bindingPath = BindingStatus;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Status = policyViewModel.PolicyCollection[i].Status;
                        }
                    }
                    SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameFrequency:
                    bindingPath = BindingFrequency;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Frequency = policyViewModel.PolicyCollection[i].Frequency;
                        }
                    }
                    SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameType:
                    bindingPath = BindingType;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Type = policyViewModel.PolicyCollection[i].Type;
                        }
                    }
                    break;
                case ColumnNamePlanCode:
                    bindingPath = BindingPlanCode;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PlanCode = policyViewModel.PolicyCollection[i].PlanCode;
                        }
                    }
                    break;
                case ColumnNameRating:
                    bindingPath = BindingRating;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Rating = policyViewModel.PolicyCollection[i].Rating;
                        }
                    }
                    break;
                case ColumnNameClass:
                    bindingPath = BindingClass;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Class = policyViewModel.PolicyCollection[i].Class;
                        }
                    }
                    break;
                case ColumnNameCurrency:
                    bindingPath = BindingCurrency;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Currency = policyViewModel.PolicyCollection[i].Currency;
                        }
                    }
                    break;
                case ColumnNamePolicyDate:
                    bindingPath = BindingPolicyDate;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PolicyDate = policyViewModel.PolicyCollection[i].PolicyDate;
                        }
                    }
                    dataGridColumn.Binding = new Binding(bindingPath);
                    dataGridColumn.Binding.StringFormat = "MMM d, yyyy";
                    break;
                case ColumnNamePlacedOn:
                    bindingPath = BindingPlacedOn;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PlacedOn = policyViewModel.PolicyCollection[i].PlacedOn;
                        }
                    }
                    dataGridColumn.Binding = new Binding(bindingPath);
                    dataGridColumn.Binding.StringFormat = "MMM d, yyyy";
                    break;
                case ColumnNameReprojectedOn:
                    bindingPath = BindingReprojectedOn;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].ReprojectedOn = policyViewModel.PolicyCollection[i].ReprojectedOn;
                        }
                    }
                    dataGridColumn.Binding = new Binding(bindingPath);
                    dataGridColumn.Binding.StringFormat = "MMM d, yyyy";
                    break;
                case ColumnNameAge:
                    bindingPath = BindingAge;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Age = policyViewModel.PolicyCollection[i].Age;
                        }
                    }
                    break;
                case ColumnNamePolicyNotes:
                    bindingPath = BindingPolicyNotes;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PolicyNotes = policyViewModel.PolicyCollection[i].PolicyNotes;
                        }
                    }
                    break;
                case ColumnNameClientNotes:
                    bindingPath = BindingClientNotes;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].ClientNotes = policyViewModel.PolicyCollection[i].ClientNotes;
                        }
                    }
                    break;
                case ColumnNameInternalNotes:
                    bindingPath = BindingInternalNotes;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].InternalNotes = policyViewModel.PolicyCollection[i].InternalNotes;
                        }
                    }
                    break;
                case ColumnNameOwner:
                    bindingPath = BindingOwner;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Owner = policyViewModel.PolicyCollection[i].Owner;
                        }
                    }
                    break;
                case ColumnNameBeneficiary:
                    bindingPath = BindingBeneficiary;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Beneficiary = policyViewModel.PolicyCollection[i].Beneficiary;
                        }
                    }
                    break;
                case ColumnNameInsured:
                    bindingPath = BindingInsured;
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Insured = policyViewModel.PolicyCollection[i].Insured;
                        }
                    }
                    break;
                default:
                    break;
            }
            Style elementStyle = new Style(typeof(TextBlock));
            elementStyle.Setters.Add(new Setter(TextBlock.TextWrappingProperty, TextWrapping.WrapWithOverflow));
            elementStyle.Setters.Add(new Setter(VerticalContentAlignmentProperty, VerticalAlignment.Center));
            elementStyle.Setters.Add(new Setter(VerticalAlignmentProperty, VerticalAlignment.Center));
            if(columnName == ColumnNameFaceAmount || columnName == ColumnNamePayment)
            {
                elementStyle.Setters.Add(new Setter(HorizontalAlignmentProperty, HorizontalAlignment.Right));
                Style headerStyle = new Style(typeof(DataGridColumnHeader), (Style)FindResource("HeaderStyle"));
                headerStyle.Setters.Add(new Setter(HorizontalAlignmentProperty, HorizontalAlignment.Center));
                dataGridColumn.HeaderStyle = headerStyle;
            }

            dataGridColumn.ElementStyle = elementStyle;
            dataGridColumn.Header = columnName;
            if(dataGridColumn.Binding == null)
            dataGridColumn.Binding = new Binding(bindingPath);

            return dataGridColumn;
        }
        private DataGridColumn AddDataGridColumnIllustration(string columnName)
        {
            DataGridTextColumn dataGridTextColumn = new DataGridTextColumn();
            string bindingPath = string.Empty;
            switch (columnName)
            {
                case ColumnNameYear:
                    bindingPath = BindingYear;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].Year = policyViewModel.PolicyIllustrationCollection[i].Year;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameAD:
                    bindingPath = BindingAD;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].AnnualDeposit = policyViewModel.PolicyIllustrationCollection[i].AnnualDeposit;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameADA:
                    bindingPath = BindingADA;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].AnnualDepositActual = policyViewModel.PolicyIllustrationCollection[i].AnnualDepositActual;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameADR:
                    bindingPath = BindingADR;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].AnnualDepositReprojection = policyViewModel.PolicyIllustrationCollection[i].AnnualDepositReprojection;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameCV:
                    bindingPath = BindingCV;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].CashValue = policyViewModel.PolicyIllustrationCollection[i].CashValue;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameCVA:
                    bindingPath = BindingCVA;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].CashValueActual = policyViewModel.PolicyIllustrationCollection[i].CashValueActual;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameCVR:
                    bindingPath = BindingCVR;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].CashValueReprojection = policyViewModel.PolicyIllustrationCollection[i].CashValueReprojection;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameDB:
                    bindingPath = BindingDB;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].DeathBenefit = policyViewModel.PolicyIllustrationCollection[i].DeathBenefit;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameDBA:
                    bindingPath = BindingDBA;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].DeathBenefitActual = policyViewModel.PolicyIllustrationCollection[i].DeathBenefitActual;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameDBR:
                    bindingPath = BindingDBR;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].DeathBenefitReprojection = policyViewModel.PolicyIllustrationCollection[i].DeathBenefitReprojection;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameACB:
                    bindingPath = BindingACB;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].AdjustedCostBase = policyViewModel.PolicyIllustrationCollection[i].AdjustedCostBase;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameACBA:
                    bindingPath = BindingACBA;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].AdjustedCostBaseActual = policyViewModel.PolicyIllustrationCollection[i].AdjustedCostBaseActual;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameACBR:
                    bindingPath = BindingACBR;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].AdjustedCostBaseReprojection = policyViewModel.PolicyIllustrationCollection[i].AdjustedCostBaseReprojection;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameNCPI:
                    bindingPath = BindingNCPI;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].NCPI = policyViewModel.PolicyIllustrationCollection[i].NCPI;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameNCPIA:
                    bindingPath = BindingNCPIA;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].NCPIActual = policyViewModel.PolicyIllustrationCollection[i].NCPIActual;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                case ColumnNameNCPIR:
                    bindingPath = BindingNCPIR;
                    if (policyViewModel.PolicyIllustrationCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyIllustrationCollection.Count(); i++)
                        {
                            policyViewModel.PolicyIllustrationCollection[i].NCPIReprojection = policyViewModel.PolicyIllustrationCollection[i].NCPIReprojection;
                        }
                    }
                    //SetCellStyle(dataGridColumn, bindingPath);
                    break;
                default:
                    break;
            }
            TextBlock tbHeader = new TextBlock();
            tbHeader.TextWrapping = TextWrapping.Wrap;
            tbHeader.Text = columnName;

            Style elementStyle = new Style(typeof(TextBlock));
            //elementStyle.Setters.Add(new Setter(TextBlock.TextWrappingProperty, TextWrapping.Wrap));
            //dataGridTextColumn.ElementStyle = elementStyle;
            dataGridTextColumn.Header = tbHeader;
            dataGridTextColumn.MinWidth = 60;

            if (dataGridTextColumn.Binding == null)
                dataGridTextColumn.Binding = new Binding(bindingPath);

            return dataGridTextColumn;
        }
        private void SetCellStyle(DataGridTextColumn dataGridColumn, string bindingPath)
        {
            var binding = new Binding(bindingPath);
            dataGridColumn.IsReadOnly = true;
            Style cellStyle = new Style(typeof(DataGridCell));
            cellStyle.Setters.Add(new Setter(FontWeightProperty, FontWeights.Bold));
            cellStyle.Setters.Add(new Setter(BorderThicknessProperty, new Thickness(0)));
            cellStyle.Setters.Add(new Setter(ForegroundProperty, Brushes.Black));
            if (bindingPath == BindingCompanyName)
            {
                Binding backgroundBinding = new Binding(bindingPath) { Converter = new CompanyCellBackgroundConverter() };
                cellStyle.Setters.Add(new Setter(BackgroundProperty, backgroundBinding));
                cellStyle.Setters.Add(new Setter(MarginProperty, new Thickness(0,0,10,0)));
            }
            else
            {
                cellStyle.Setters.Add(new Setter(BackgroundProperty, Brushes.Transparent));
            }
            if(bindingPath == BindingFaceAmount)
            {
                binding.StringFormat = "#,#";
                cellStyle.Setters.Add(new Setter(MarginProperty, new Thickness(0, 0, 10, 0)));
            }
            if(bindingPath == BindingPayment)
            {
                binding.StringFormat = "#,#.00";
                cellStyle.Setters.Add(new Setter(MarginProperty, new Thickness(0, 0, 10, 0)));
            }
            dataGridColumn.Binding = binding;
            dataGridColumn.CellStyle = cellStyle;
        }
        private void DefaultPolicyGridColumns(List<string> columnNames)
        {
            DataGridColumn policyEditColumn = null;
            if(policies.Columns.Count == 1)
            {
                policyEditColumn = policies.Columns[0];
                policies.Columns.RemoveAt(0);
            }
            for (int a = 0; a < columnNames.Count; a++)
            {
                policies.Columns.Insert(a, AddDataGridColumn(columnNames[a]));
            }
            policies.Columns.Insert(0, policyEditColumn);
        }
        private void DefaultIllustrationGridColumns(List<string> columnNames)
        {
            DataGridColumn IllustrationEditColumn = null;
            if (illustration.Columns.Count == 1)
            {
                IllustrationEditColumn = illustration.Columns[0];
                illustration.Columns.RemoveAt(0);
            }
            for (int a = 0; a < columnNames.Count; a++)
            {
                illustration.Columns.Insert(a, AddDataGridColumnIllustration(columnNames[a]));
            }
            illustration.Columns.Insert(0, IllustrationEditColumn);
        }
        private void SetAutomCompleteStyle(AutoCompleteBox autoCompleteBox)
        {
            autoCompleteBox.autoList.Background = (SolidColorBrush)(new BrushConverter().ConvertFrom("#FFFFFF"));
            autoCompleteBox.autoList.Foreground = (SolidColorBrush)(new BrushConverter().ConvertFrom("#000000"));
            autoCompleteBox.autoList.BorderThickness = new Thickness(1, 0, 1, 1);
            autoCompleteBox.autoList.BorderBrush = (SolidColorBrush)(new BrushConverter().ConvertFrom("#808080"));
            autoCompleteBox.autoList.Width = autoCompleteBox.autoTextBox.MinWidth - 34;
        }
        private void InitializeViewModel()
        {
            if (policyViewModel == null
                && (PolicyViewModel)this.DataContext != null)
            {
                policyViewModel = (PolicyViewModel)this.DataContext;
            }
        }
        #endregion Methods
    }
}
