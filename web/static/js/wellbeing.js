import React from "react";

class WellbeingFormContainer extends React.Component{
  constructor(){
    super()
    this.state = {
      wellbeing: {
        good: [
          "one", "two", "three"
        ]
      }
    }
  }
  componentDidMount(){
    $.getJSON("/wellbeings/new", json => {
      this.setState({wellbeing: json.data})
    }
    )
  }
  render(){
    return (<WellbeingForm wellbeing={this.state.wellbeing}/>)
  }
}

class WellbeingForm extends React.Component{
  render(){
    return (<form>
        {this.props.wellbeing.good.map( function(item){
          return (<li key={item}>{item}</li>);
        })}
      </form>)
  }
}
module.exports = { WellbeingFormContainer }
