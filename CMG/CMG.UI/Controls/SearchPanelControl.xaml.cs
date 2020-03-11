using CMG.Application.DTO;
using CMG.Application.ViewModel;
using CMG.UI.View;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Threading;

namespace CMG.UI.Controls
{
    public partial class SearchPanelControl : UserControl
    {
        #region Member variables
        private DragAdorner _adorner;
        private AdornerLayer _layer;
        private Point startPoint;
        private PeopleViewModel peopleViewModel;
        public event RoutedEventHandler CustomClick;
        #endregion Member variables
        public SearchPanelControl()
        {
            InitializeComponent();
            Dispatcher.BeginInvoke(DispatcherPriority.Loaded, new Action(() =>
            {
                if (peopleViewModel == null)
                {
                    peopleViewModel = (PeopleViewModel)this.DataContext;
                }
            }));

        }
        private void ButtonSearchSliderClose_Click(object sender, RoutedEventArgs e)
        {
            CustomClick?.Invoke(this, new RoutedEventArgs());
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
                peopleViewModel = (PeopleViewModel)this.DataContext;
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
                            peopleViewModel.SearchOptions[i].ColumnOrder = i + 1;
                        }
                        peopleViewModel.SearchOptions.Where(s => s.ColumnName == draggedData.ColumnName).Select(o => { o.ColumnOrder = droppedDataIndex; return o; }).ToList();
                        peopleViewModel.SearchOptions = new ObservableCollection<ViewSearchOptionsDto>(peopleViewModel.SearchOptions.OrderBy(c => c.ColumnOrder).ToList());
                    }
                    else if (droppedDataIndex > draggedDataIndex)
                    {
                        for (var i = droppedDataIndex; i > draggedDataIndex; i--)
                        {
                            peopleViewModel.SearchOptions[i].ColumnOrder = i - 1;
                        }
                        peopleViewModel.SearchOptions.Where(s => s.ColumnName == draggedData.ColumnName).Select(o => { o.ColumnOrder = droppedDataIndex; return o; }).ToList();
                        peopleViewModel.SearchOptions = new ObservableCollection<ViewSearchOptionsDto>(peopleViewModel.SearchOptions.OrderBy(c => c.ColumnOrder).ToList());
                    }
                    peopleViewModel.SaveSearchOptions();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        private void UserControlPolicyNumber_Loaded(object sender, RoutedEventArgs e)
        {
            if (peopleViewModel != null
                && !string.IsNullOrEmpty(peopleViewModel.PolicyNumber))
            {

                AutoCompleteBox autoCompleteBox = (AutoCompleteBox)sender;
                if (autoCompleteBox != null)
                {
                    autoCompleteBox.autoTextBox.Text = peopleViewModel.PolicyNumber;
                }
                var searchOption = (ViewSearchOptionsDto)autoCompleteBox.DataContext;
                if (searchOption.ColumnOrder == 0)
                {
                    autoCompleteBox.autoTextBox.Focus();
                }
            }
        }

        #region Helper Methods
        private void BeginDrag(MouseEventArgs e)
        {
            ListView searchOptionsListView = SearchOptionsList;
            ListViewItem listViewItem = FindAnchestor<ListViewItem>((DependencyObject)e.OriginalSource);
            if (listViewItem == null)
                return;

            var currentColumn = searchOptionsListView.ItemContainerGenerator.ItemFromContainer(listViewItem);
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
        #endregion
    }
}
