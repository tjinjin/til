import React, { PropTypes } from 'react';

class Link extends React.Component {
  render() {
    if (this.props.active) {
      return <span>{this.props.children}</span>;
    }


  return (
    <a href="#"
      onClick={e => {
        e.preventDefault()
        this.props.onClick()
      }}
    >
      {this.props.children}
  </a>);
  }
}

Link.propTypes = {
  active: PropTypes.bool.isRequired,
  children: PropTypes.node.isRequired,
  onClick: PropTypes.func.isRequired
};

export default Link;
