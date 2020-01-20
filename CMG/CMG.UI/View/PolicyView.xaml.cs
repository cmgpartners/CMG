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

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for PolicyView.xaml
    /// </summary>
    public partial class PolicyView : UserControl
    {
        private DragAdorner _adorner;
        private AdornerLayer _layer;
        private Point startPoint;
        private PolicyViewModel policyViewModel;
        public PolicyView()
        {
            InitializeComponent();
            Dispatcher.BeginInvoke(DispatcherPriority.Loaded, new Action(() => {
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
            catch(Exception ex)
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
            DragDropEffects de = DragDrop.DoDragDrop(SearchOptionsList, data, DragDropEffects.Move);
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
            if(entityTypeAutoComplete != null)
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
            if(policyNumberAutoComplete != null)
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
    }
}
