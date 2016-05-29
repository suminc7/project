using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class EyeCursor : MonoBehaviour {

	public GameObject centerEyes;
	public GameObject fillObj;

	private Image fillControl;
	private float _fillAmount;
	private string tagStr;

	public float fillAmount
	{
		get { return _fillAmount; }
		set	{
			_fillAmount = value;
		}
	}

	void Start () {

		fillControl = fillObj.GetComponent<Image> ();
		fillControl.fillAmount = 0;
	
	}
	
	// Update is called once per frame
	void Update () {

	}

	public void Reset(){

	}

	public void Active(){
		_fillAmount += Time.deltaTime * 1.5f;
		UpdateAmount ();
	}

	public void Deactive(){
		_fillAmount -= Time.deltaTime;
		UpdateAmount ();
	}

	public void UpdateAmount(){
		_fillAmount = Mathf.Clamp01 (_fillAmount);
		if(fillControl) fillControl.fillAmount = _fillAmount;

	}

}
