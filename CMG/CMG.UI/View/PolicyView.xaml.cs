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
        private DragAdorner _adorner;
        private AdornerLayer _layer;
        private Point startPoint;
        private PolicyViewModel policyViewModel;
        private ContextMenu ctxMenu;
        private MenuItem menuItem;

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
        private const string MenuItemAddColumns = "Add Columns";
        private const string MenuItemRemove = "Remove";

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
        #endregion

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
        private void SearchOptionsList_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            startPoint = e.GetPosition(null);
        }
        private void SearchOptionsList_PreviewMouseMove(object sender, MouseEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                Point position = e.GetPosition(null);

                if (Math.Abs(position.X - startPoint.X) > SystemParameters.MinimumHorizontalDragDistance ||
                    Math.Abs(position.Y - startPoint.Y) > SystemParameters.MinimumVerticalDragDistance)
                {
                    BeginDrag(e);
                }
            }
        }
        private void SearchOptionsList_Drop(object sender, DragEventArgs e)
        {
            try
            {
                policyViewModel = (PolicyViewModel)this.DataContext;
                ListView searchOptionsListView = (ListView)sender;
                ViewSearchOptionsDto droppedData = (ViewSearchOptionsDto)FindAnchestor<ListViewItem>((DependencyObject)e.OriginalSource)?.DataContext;
                ViewSearchOptionsDto draggedData = (ViewSearchOptionsDto)searchOptionsListView.SelectedItem;

                var droppedDataIndex = searchOptionsListView.Items.IndexOf(droppedData);
                var draggedDataIndex = searchOptionsListView.Items.IndexOf(draggedData);

                if (draggedDataIndex >= 0 && droppedDataIndex >= 0)
                {
                    if (draggedDataIndex > droppedDataIndex)
                    {
                        for (var i = droppedDataIndex; i < draggedDataIndex; i++)
                        {
                            policyViewModel.SearchOptions[i].ColumnOrder = i + 1;
                        }
                        policyViewModel.SearchOptions.Where(s => s.ColumnName == draggedData.ColumnName).Select(o => { o.ColumnOrder = droppedDataIndex; return o; }).ToList();
                        policyViewModel.SearchOptions = new ObservableCollection<ViewSearchOptionsDto>(policyViewModel.SearchOptions.OrderBy(c => c.ColumnOrder).ToList());
                    }
                    else if (droppedDataIndex > draggedDataIndex)
                    {
                        for (var i = droppedDataIndex; i > draggedDataIndex; i--)
                        {
                            policyViewModel.SearchOptions[i].ColumnOrder = i - 1;
                        }
                        policyViewModel.SearchOptions.Where(s => s.ColumnName == draggedData.ColumnName).Select(o => { o.ColumnOrder = droppedDataIndex; return o; }).ToList();
                        policyViewModel.SearchOptions = new ObservableCollection<ViewSearchOptionsDto>(policyViewModel.SearchOptions.OrderBy(c => c.ColumnOrder).ToList());
                    }
                    policyViewModel.SaveSearchOptions();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        private void UserControlPolicyNumber_Loaded(object sender, RoutedEventArgs e)
        {
            string value = string.Empty;
            if (policyViewModel != null
                && !string.IsNullOrEmpty(policyViewModel.PolicyNumber))
            {

                AutoCompleteBox autoCompleteBox = (AutoCompleteBox)sender;
                if (autoCompleteBox != null)
                {
                    autoCompleteBox.autoTextBox.Text = policyViewModel.PolicyNumber;
                }
                var searchOption = (ViewSearchOptionsDto)autoCompleteBox.DataContext;
                if (searchOption.ColumnOrder == 0)
                {
                    autoCompleteBox.autoTextBox.Focus();
                }
            }
        }
        private void Policies_AutoGenerateColumns(object sender, EventArgs e)
        {
            ctxMenu = new ContextMenu();
            menuItem = new MenuItem();
            menuItem.Header = MenuItemAddColumns;
            ctxMenu.Items.Add(menuItem);

            if (policyViewModel == null)
            {
                policyViewModel = (PolicyViewModel)this.DataContext;
            }
            foreach (var columns in policyViewModel.ColumnNames)
            {
                var subMenu = new MenuItem();
                subMenu.Header = columns;
                subMenu.Click += SubMenuAddColumn_Click;

                menuItem.Items.Add(subMenu);
            }

            menuItem = new MenuItem();
            menuItem.Header = MenuItemRemove;
            menuItem.Click += MenuItemRemoveColumn_Click;

            ctxMenu.Items.Add(menuItem);

            PolicyGridDefaultSetting();
            for (int i = 0; i < policies.Columns.Count; i++)
            {
                ResizePolicyGridColumns(policies.Columns[i].Header.ToString());
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
        private void SubMenuAddColumn_Click(object sender, RoutedEventArgs e)
        {
            MenuItem selectedMenu = (MenuItem)sender;
            var columnIndex = policies.Columns.IndexOf(policies.Columns.FirstOrDefault(c => c.Header.ToString() == selectedMenu.DataContext.ToString()));
            var newColumnName = selectedMenu.Header.ToString();
            var isColumnExist = policies.Columns.Any(x => x.Header.ToString() == newColumnName);
            if (!string.IsNullOrEmpty(newColumnName))
            {
                if (!isColumnExist)
                {
                    policies.Columns.Insert(columnIndex, AddDataGridColumn(newColumnName));
                    for (int i = 0; i < policies.Columns.Count; i++)
                    {
                        ResizePolicyGridColumns(policies.Columns[i].Header.ToString());
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
                        ResizePolicyGridColumns(policies.Columns[i].Header.ToString());
                    }
                }
            }
        }

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
        private void ResizePolicyGridColumns(string columnName)
        {
            switch (columnName)
            {
                case ColumnNamePlanCode:
                    SetPolicyGridColumnWidth(columnName, 70);
                    break;
                case ColumnNameCompany:
                    SetPolicyGridColumnWidth(columnName, 110);
                    break;
                case ColumnNameFaceAmount:
                case ColumnNamePayment:
                    SetPolicyGridColumnWidth(columnName, 90);
                    break;
                case ColumnNameFrequency:
                case ColumnNameType:
                case ColumnNameRating:
                case ColumnNameClass:
                case ColumnNameCurrency:
                    SetPolicyGridColumnWidth(columnName, 80);
                    break;
                case ColumnNamePolicyNumber:
                case ColumnNamePolicyDate:
                case ColumnNamePlacedOn:
                case ColumnNameReprojectedOn:
                case ColumnNameStatus:
                case ColumnNameInsured:
                    SetPolicyGridColumnWidth(columnName, 100);
                    break;
                case ColumnNameAge:
                    SetPolicyGridColumnWidth(columnName, 50);
                    break;
                case ColumnNamePolicyNotes:
                case ColumnNameClientNotes:
                case ColumnNameInternalNotes:
                case ColumnNameBeneficiary:
                case ColumnNameOwner:

                    SetPolicyGridColumnWidth(columnName, 150);
                    break;
                default:
                    SetPolicyGridColumnWidth(columnName, 0);
                    break;
            }
        }
        private void SetPolicyGridColumnWidth(string columnName, int width)
        {
            DataGridColumn dataGridColumn = policies.Columns.Where(x => x.Header.ToString() == columnName).FirstOrDefault();
            if (dataGridColumn != null)
            {
                if (width == 0)
                {
                    dataGridColumn.Width = DataGridLength.Auto;
                }
                else
                {
                    dataGridColumn.Width = width;
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
        private void RemovePolicyGridColumn(string columnName)
        {
            DataGridColumn dataGridColumn;
            dataGridColumn = policies.Columns.Where(x => x.Header.ToString() == columnName).FirstOrDefault();
            if (dataGridColumn != null)
                policies.Columns.Remove(dataGridColumn);
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
        private void BeginDrag(MouseEventArgs e)
        {
            try
            {
                ListView searchOptionsListView = SearchOptionsList;
                ListViewItem listViewItem = FindAnchestor<ListViewItem>((DependencyObject)e.OriginalSource);
                if (listViewItem == null)
                    return;

                var currentColumn = searchOptionsListView.ItemContainerGenerator.ItemFromContainer(listViewItem);
                //setup the drag adorner.
                InitialiseAdorner(listViewItem);
                DataObject data = new DataObject(currentColumn);
                DragDropEffects de = DragDrop.DoDragDrop(SearchOptionsList, data, DragDropEffects.Move);
                if (_adorner != null)
                {
                    AdornerLayer.GetAdornerLayer(searchOptionsListView).Remove(_adorner);
                    _adorner = null;
                }
            }
            catch { }
        }
        private void InitialiseAdorner(ListViewItem listViewItem)
        {
            VisualBrush brush = new VisualBrush(listViewItem);
            _adorner = new DragAdorner((UIElement)listViewItem, listViewItem.RenderSize, brush);
            _adorner.Opacity = 0.5;
            _layer = AdornerLayer.GetAdornerLayer(SearchOptionsList as Visual);
            _layer.Add(_adorner);
        }
        private static T FindAnchestor<T>(DependencyObject current)
        where T : DependencyObject
        {
            do
            {
                if (current is T)
                {
                    return (T)current;
                }
                current = VisualTreeHelper.GetParent(current);
            }
            while (current != null);
            return null;
        }

        private void SetAutomCompleteStyle(AutoCompleteBox autoCompleteBox)
        {
            autoCompleteBox.autoList.Background = (SolidColorBrush)(new BrushConverter().ConvertFrom("#FFFFFF"));
            autoCompleteBox.autoList.Foreground = (SolidColorBrush)(new BrushConverter().ConvertFrom("#000000"));
            autoCompleteBox.autoList.BorderThickness = new Thickness(1, 0, 1, 1);
            autoCompleteBox.autoList.BorderBrush = (SolidColorBrush)(new BrushConverter().ConvertFrom("#808080"));
            autoCompleteBox.autoList.Width = autoCompleteBox.autoTextBox.MinWidth - 34;
        }
        #endregion Methods
    }
}
