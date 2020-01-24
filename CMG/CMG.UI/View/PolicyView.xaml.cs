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
        private const string MenuItemAddColumns = "Add Columns";
        private const string MenuItemRemove = "Remove";
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

            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(450) };
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
            IllustrationSliderPanel.Width = PolicyMainView.ActualWidth - 100;
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
            PolicyMainView.Background = Brushes.Black;
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
        private void SearchOptionsList_PreviewMouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            startPoint = e.GetPosition(null);
        }
        private void SearchOptionsList_PreviewMouseMove(object sender, System.Windows.Input.MouseEventArgs e)
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
        private void BeginDrag(MouseEventArgs e)
        {
            ListView searchOptionsListView = SearchOptionsList;
            ListViewItem listViewItem = FindAnchestor<ListViewItem>((DependencyObject)e.OriginalSource);
            if (listViewItem == null)
                return;

            var currentColumn = searchOptionsListView.ItemContainerGenerator.ItemFromContainer(listViewItem);
            //setup the drag adorner.
            InitialiseAdorner(listViewItem);
            DataObject data = new DataObject(currentColumn);
            if (_adorner != null)
            {
                AdornerLayer.GetAdornerLayer(searchOptionsListView).Remove(_adorner);
                _adorner = null;
            }
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
        private void EntityTypePanel_Loaded(object sender, RoutedEventArgs e)
        {
            WrapPanel entityTypePanel = (WrapPanel)sender;
            var entityTypeAutoComplete = entityTypePanel.Children.Count > 0 ? (AutoCompleteBox)entityTypePanel.Children[1] : null;
            if (entityTypeAutoComplete != null)
            {
                if (policyViewModel != null
                    && !string.IsNullOrEmpty(policyViewModel.EntityType))
                {
                    entityTypeAutoComplete.autoTextBox.Text = policyViewModel.EntityType;
                }

            }
        }
        private void PolicyNumberPanel_Loaded(object sender, RoutedEventArgs e)
        {
            WrapPanel policyNumberPanel = (WrapPanel)sender;
            var policyNumberAutoComplete = policyNumberPanel.Children.Count > 0 ? (AutoCompleteBox)policyNumberPanel.Children[1] : null;
            if (policyNumberAutoComplete != null)
            {
                if (policyViewModel != null
                    && !string.IsNullOrEmpty(policyViewModel.PolicyNumber))
                {
                    policyNumberAutoComplete.autoTextBox.Text = policyViewModel.PolicyNumber;
                }
            }
        }
        private void CompanyNamePanel_Loaded(object sender, RoutedEventArgs e)
        {
            WrapPanel companyNamePanel = (WrapPanel)sender;
            var companyNameAutoComplete = companyNamePanel.Children.Count > 0 ? (AutoCompleteBox)companyNamePanel.Children[1] : null;
            if (companyNameAutoComplete != null)
            {
                if (policyViewModel != null
                    && !string.IsNullOrEmpty(policyViewModel.CompanyName))
                {
                    companyNameAutoComplete.autoTextBox.Text = policyViewModel.CompanyName;
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
                }
                else
                {
                    policyViewModel._notifier.ShowError("Column " + newColumnName + " already exists");
                }
                for (int i = 0; i < policies.Columns.Count; i++)
                {
                    ResizePolicyGridColumns(policies.Columns[i].Header.ToString());
                }
                ViewSearchOptionsDto newColumnView = new ViewSearchOptionsDto() { ColumnName = newColumnName, ColumnOrder = columnIndex };
                ResetPolicyColumnsIndex(columnIndex - 1);
                policyViewModel.PolicyColumns.Insert(columnIndex - 1, newColumnView);
                policyViewModel.SaveOptionKeyPolicyColumns();
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
        private void policies_ColumnHeaderDragCompleted(object sender, DragCompletedEventArgs e)
        {

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
                case "Plan Code":
                    SetPolicyGridColumnWidth(columnName, 70);
                    break;
                case "Company":
                    SetPolicyGridColumnWidth(columnName, 110);
                    break;
                case "Face Amount":
                case "Payment":
                    SetPolicyGridColumnWidth(columnName, 110);
                    break;
                case "Frequency":
                case "Type":
                case "Rating":
                case "Class":
                case "Currency":
                    SetPolicyGridColumnWidth(columnName, 80);
                    break;
                case "Policy Number":
                case "Policy Date":
                case "Placed On":
                case "Reprojected On":
                case "Status":
                    SetPolicyGridColumnWidth(columnName, 100);
                    break;
                case "Age":
                    SetPolicyGridColumnWidth(columnName, 50);
                    break;
                case "Policy Notes":
                case "Client Notes":
                case "Internal Notes":
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
                case "Policy Number":
                    bindingPath = "PolicyNumber";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PolicyNumber = policyViewModel.PolicyCollection[i].PolicyNumber;
                        }
                    }
                    break;
                case "Company":
                    bindingPath = "CompanyName";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].CompanyName = policyViewModel.PolicyCollection[i].CompanyName;
                        }
                    }
                    break;
                case "Face Amount":
                    bindingPath = "FaceAmount";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].FaceAmount = policyViewModel.PolicyCollection[i].FaceAmount;
                        }
                    }
                    break;
                case "Payment":
                    bindingPath = "Payment";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Payment = policyViewModel.PolicyCollection[i].Payment;
                        }
                    }
                    break;
                case "Status":
                    bindingPath = "Status";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Status = policyViewModel.PolicyCollection[i].Status;
                        }
                    }
                    break;
                case "Frequency":
                    bindingPath = "Frequency";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Frequency = policyViewModel.PolicyCollection[i].Frequency;
                        }
                    }
                    break;
                case "Type":
                    bindingPath = "Type";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Type = policyViewModel.PolicyCollection[i].Type;
                        }
                    }
                    break;
                case "Plan Code":
                    bindingPath = "PlanCode";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PlanCode = policyViewModel.PolicyCollection[i].PlanCode;
                        }
                    }
                    break;
                case "Rating":
                    bindingPath = "Rating";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Rating = policyViewModel.PolicyCollection[i].Rating;
                        }
                    }
                    break;
                case "Class":
                    bindingPath = "Class";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Class = policyViewModel.PolicyCollection[i].Class;
                        }
                    }
                    break;
                case "Currency":
                    bindingPath = "Currency";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Currency = policyViewModel.PolicyCollection[i].Currency;
                        }
                    }
                    break;
                case "Policy Date":
                    bindingPath = "PolicyDate";
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
                case "Placed On":
                    bindingPath = "PlacedOn";
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
                case "Reprojected On":
                    bindingPath = "ReprojectedOn";
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
                case "Age":
                    bindingPath = "Age";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].Age = policyViewModel.PolicyCollection[i].Age;
                        }
                    }
                    break;
                case "Policy Notes":
                    bindingPath = "PolicyNotes";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].PolicyNotes = policyViewModel.PolicyCollection[i].PolicyNotes;
                        }
                    }
                    break;
                case "Client Notes":
                    bindingPath = "ClientNotes";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].ClientNotes = policyViewModel.PolicyCollection[i].ClientNotes;
                        }
                    }
                    break;
                case "Internal Notes":
                    bindingPath = "InternalNotes";
                    if (policyViewModel.PolicyCollection != null)
                    {
                        for (int i = 0; i < policyViewModel.PolicyCollection.Count(); i++)
                        {
                            policyViewModel.PolicyCollection[i].InternalNotes = policyViewModel.PolicyCollection[i].InternalNotes;
                        }
                    }
                    break;
                default:
                    break;
            }
            dataGridColumn.Header = columnName;
            if(dataGridColumn.Binding == null)
            dataGridColumn.Binding = new Binding(bindingPath);            

            return dataGridColumn;
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
        #endregion Methods        
    }
}
